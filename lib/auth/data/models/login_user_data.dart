class LoginUserData {
  final String? login;
  final String? password;

  const LoginUserData(this.login, this.password);

  bool get isValid => login != null && password != null;
}