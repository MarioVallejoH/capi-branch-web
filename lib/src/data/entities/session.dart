// To parse this JSON data, do
//
//     final session = sessionFromJson(jsonString);

/// Session data entity
class Session {
  /// from Map (json) constructor
  factory Session.fromJson(dynamic json) => Session(
        accessToken: json['token'],
      );

  /// CLass constructor
  Session({
    required this.accessToken,
  });

  /// Session access token
  String accessToken;
}
