import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:small_warehouse/auth/data/models/login_user_data.dart';

class AuthCredentialsStorage {
  static const _loginKey = 'login';
  static const _passwordKey = 'password';

  const AuthCredentialsStorage();

  Future<LoginUserData> get savedCredentials async {
    const storage = FlutterSecureStorage();
    final login = await storage.read(key: _loginKey);
    final password = await storage.read(key: _passwordKey);
    return LoginUserData(login, password);
  }

  Future<bool> saveCredentials(LoginUserData credentials) async {
    if (!credentials.isValid) return false;
    const storage = FlutterSecureStorage();
    final loginSaveFuture =
    storage.write(key: _loginKey, value: credentials.login);
    final passwordSaveFuture =
    storage.write(key: _passwordKey, value: credentials.password);

    bool caughtErrors = false;
    await Future.wait([loginSaveFuture, passwordSaveFuture], eagerError: true)
        .catchError(
          (error) {
        caughtErrors = true;
      },
    );
    return caughtErrors;
  }
}