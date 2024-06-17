/// User Entity
///
/// Used to manage Users data fetch from backend
class User {
  ///
  User({
    required this.name,
  });

  /// From json map constructor
  factory User.fromJson(dynamic json) => User(
        name: json['name'],
      );

  /// User name
  String name;
}
