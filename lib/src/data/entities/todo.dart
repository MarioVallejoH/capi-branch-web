import 'package:web/src/utils/locator.dart';

/// Todo Entity
///
/// Used to manage Todos data fetch from backend
class Todo {
  ///
  Todo({
    required this.id,
    required this.title,
    required this.completed,
    required this.priority,
  });

  /// From json map constructor
  factory Todo.fromJson(dynamic json) => Todo(
        id: json['id'],
        title: json['title'],
        completed: json['completed'],
        priority: json['priority'],
      );

  /// Todo name
  String id;
  String title;
  String completed;
  String priority;

  static List<Todo> froJsonList(List data) {
    List<Todo> out = [];
    for (var item in data) {
      try {
        out.add(Todo.fromJson(item));
      } catch (e) {
        GlobalLocator.appLogger.e(e);
      }
    }
    return out;
  }
}
