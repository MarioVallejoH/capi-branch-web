/// UserLogin DTO
class UserLoginDTO {
  /// Class constructor
  UserLoginDTO({
    required this.username,
    required this.password,
  });

  /// User e-mail
  final String username;

  /// User password
  final String password;

  /// Parse a [UserLoginDTO] object into a Map
  Map<String, dynamic> toJson() => {
        'username': username.toLowerCase(),
        'password': password,
      };
}
