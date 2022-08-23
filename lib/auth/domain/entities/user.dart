class User {
  final int? userId;
  final String name;
  final String email;
  final String password;
  final String phone;
  final int roleId;

  User(this.userId, this.name, this.email, this.password, this.phone,
      this.roleId);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json[_JsonFields.id],
      json[_JsonFields.email],
      json[_JsonFields.name],
      json[_JsonFields.password],
      json[_JsonFields.phone],
      json[_JsonFields.roleId],
    );
  }

  Map<String, String> toMap() {
    return {
      _JsonFields.name: name,
      _JsonFields.email: email,
      _JsonFields.phone: phone,
      _JsonFields.password: password,
    };
  }
}

class _JsonFields {
  static const id = 'user_id';
  static const name = 'name';
  static const email = 'email';
  static const password = 'password';
  static const phone = 'phone';
  static const roleId = 'role_id';
}
