/// RegisterLogin DTO
class RegisterDTO {
  /// Class constructor
  RegisterDTO({
    required this.username,
    required this.password,
  });

  /// Register e-mail
  final String username;

  /// Register password
  final String password;

  /// Parse a [RegisterDTO] object into a Map
  Map<String, dynamic> toJson() => {
        'username': username.toLowerCase(),
        'password': password,
      };
}
