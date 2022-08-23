class AuthException {
  final Exception? lastException;

  AuthException(this.lastException);
}

class AuthResponseException implements Exception {
  final String message;

  AuthResponseException(this.message);

  @override
  String toString() {
    return message;
  }
}
