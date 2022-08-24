import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:small_warehouse/auth/data/models/login_user_data.dart';
import 'package:small_warehouse/auth/domain/entities/user.dart';
import 'package:small_warehouse/auth/domain/repositories/user_repository.dart';
import 'package:small_warehouse/auth/utils/auth_credentials_storage.dart';
import 'package:small_warehouse/common/utils/custom_exception.dart';

class AuthNotifier extends ChangeNotifier {

  User? _user;

  late StreamSubscription _userSubscription;

  final UserRepository _repository;

  AuthNotifier(
      this._repository
      );

  User? get currentUser => _user;

  bool get isLoggedIn => _user != null;

  var _authException = CustomException(null);

  CustomException get authException => _authException;

  Future<void> registerAccount(
      String name,
      String email,
      String password,
      String phone,
      ) async {
    _handleAuthError(null);
    notifyListeners();
    try {
      _repository.registerUser(
          User(null, name, email,  password, phone, 0),
      );
    } on CustomResponseException catch (e) {
      _handleAuthError(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> signInWithEmail(
      String email,
      String password,
      ) async {
    _handleAuthError(null);
    notifyListeners();
    try {
      _repository.loginUser(
          email, password,
      );
    } on CustomResponseException catch (e) {
      _handleAuthError(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _handleAuthError(null);
    notifyListeners();
  }

  Future<void> subscribeToAuthUpdates(Stream<User?> userStream) async {
    _userSubscription = userStream.listen(_userStreamListener);
    await _trySignInWithStoredCredentials();
  }

  Future<void> _trySignInWithStoredCredentials() async {
    const credentialsStorage = AuthCredentialsStorage();
    LoginUserData savedCredentials;
    try {
      savedCredentials = await credentialsStorage.savedCredentials;
      if (savedCredentials.isValid) {
        _repository.loginUser(savedCredentials.login!, savedCredentials.password!);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> _userStreamListener(User? user) async {
    _user = user;
    if (user != null) {
      _handleAuthError(null);
      const AuthCredentialsStorage()
          .saveCredentials(LoginUserData(user.email, user.password));
    }
    notifyListeners();
  }

  void _handleAuthError(Exception? exception) {
    _authException = CustomException(exception);
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }
}