import 'package:web/src/data/entities/entities.dart';
import 'package:web/src/domain/dtos/dtos.dart';

/// Todo repository interface
abstract class ITodoRepository {
  /// Todo instance
  Future<Todo?> create(TodoDTO todo);

  /// Todo instance
  Future<List<Todo>?> getAll({bool completed = false, String? priority});

  /// Perform Todo delete, return a boolean
  Future<bool?> delete(String id);

  /// Perform Todo status update, return a boolean
  Future<bool?> updateStatus(bool status);
}
