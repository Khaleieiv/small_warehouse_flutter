import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:small_warehouse/auth/data/models/login_user_data.dart';
import 'package:small_warehouse/auth/domain/entities/user.dart';
import 'package:small_warehouse/auth/domain/repositories/user_repository.dart';
import 'package:small_warehouse/auth/utils/auth_credentials_storage.dart';
import 'package:small_warehouse/auth/utils/auth_exception.dart';

class AuthNotifier extends ChangeNotifier {

  User? _user;

  late StreamSubscription _userSubscription;

  AuthNotifier(
      this._repository
      );

  User? get currentUser => _user;

  bool get isLoggedIn => _user != null;

  var _authException = AuthException(null);

  AuthException get authException => _authException;

  Future<void> registerAccount(
      String email,
      String password,
      String name,
      String phone,
      ) async {
    _handleAuthError(null);
    notifyListeners();
    try {
      _repository.registerUser(
          User(null, name, email,  password, phone, 0),
      );
    } on AuthResponseException catch (e) {
      _handleAuthError(e);
    } finally {
      notifyListeners();
    }
  }
  final UserRepository _repository;

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
    } on AuthResponseException catch (e) {
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
    if (kDebugMode) {
      print(exception.toString());
    }
    _authException = AuthException(exception);
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }
}