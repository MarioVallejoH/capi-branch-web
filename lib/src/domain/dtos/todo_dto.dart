/// Todo DTO
class TodoDTO {
  /// Class constructor
  TodoDTO({
    required this.title,
    required this.priority,
  });

  /// User e-mail
  final String title;

  /// User priority
  final String priority;

  /// Parse a [TodoDTO] object into a Map
  Map<String, dynamic> toJson() => {
        'title': title.toLowerCase(),
        'priority': priority,
      };
}
