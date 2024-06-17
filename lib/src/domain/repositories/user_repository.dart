import 'package:web/src/data/entities/entities.dart';
import 'package:web/src/domain/dtos/dtos.dart';

/// User repository interface
abstract class IUserRepository {
  /// User login, perform login operation. Saves auth tokens and returns
  /// User instance
  Future<Session?> userLogin(UserLoginDTO login);

  /// Perform user registration, return a user object ID
  Future<bool?> userRegister(RegisterDTO userData);

  /// Perform user registration, return a user object ID
  Future<void> setSessionData(Session session);

  /// Perform user password change
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  ///
  Future<User> getUserData();

  /// Perform user logout on server?
  /// Delete session data stored locally
  Future<void> logout();
}
