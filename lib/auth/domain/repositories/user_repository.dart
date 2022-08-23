import 'package:small_warehouse/auth/domain/entities/user.dart';

abstract class UserRepository {
  Stream<User?> get currentUser;

  void registerUser(User userData);

  void loginUser(
    String email,
    String password,
  );
}
