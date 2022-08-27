import 'package:small_warehouse/auth/domain/entities/user.dart';

abstract class UserRepository {
  Stream<User?> get currentUser;

  Future<void> registerUser(User userData);

  Future<void> loginUser(
    String email,
    String password,
  );

  Future<void> updateProfile(User userData);
}
