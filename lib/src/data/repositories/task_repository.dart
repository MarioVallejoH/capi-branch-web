import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web/src/data/data_sources/api_datasource.dart';
import 'package:web/src/data/entities/entities.dart';
import 'package:web/src/domain/dtos/todo_dto.dart';
import 'package:web/src/domain/repositories/task_repository.dart';
import 'package:web/src/utils/utils.dart';

class TodoRepository implements ITodoRepository {
  /// Repository constructor
  TodoRepository({required this.api});

  /// APiDataSource object
  final ApiDataSource api;

  @override
  Future<Todo?> create(TodoDTO todo) async {
    final requestData = RequestData(
      path: '/task/create',
      method: Method.post,
      body: todo.toJson(),
    );
    final result = await api.request(
      requestData: requestData,
      fromJsonT: Session.fromJson,
      withAuthToken: false,
    );
    BaseResponse data;
    try {
      data = BaseResponse.fromJson(result, Todo.fromJson);
    } catch (e) {
      data = BaseResponse.fromJson(result, (_) {});
    }
    if (!data.ok) {
      GlobalLocator.appLogger.e(data.message);
      throw Exception(data.message);
    } else {
      return data.data;
    }
  }

  @override
  Future<bool?> delete(String id) async {
    final requestData = RequestData(
      path: '/task/delete',
      method: Method.delete,
      body: {'id': id},
    );
    final result = await api.request(
      requestData: requestData,
      fromJsonT: Session.fromJson,
      withAuthToken: false,
    );
    BaseResponse data;
    try {
      data = BaseResponse.fromJson(result, (_) {});
    } catch (e) {
      data = BaseResponse.fromJson(result, (_) {});
    }
    if (!data.ok) {
      GlobalLocator.appLogger.e(data.message);
      throw Exception(data.message);
    } else {
      return data.ok;
    }
  }

  @override
  Future<List<Todo>?> getAll({bool completed = false, String? priority}) async {
    final Map<String, dynamic> queryP = {
      'completed': completed,
    };
    if (priority != null) {
      queryP['priority'] = priority;
    }
    final requestData = RequestData(
      path: '/task/all',
      method: Method.get,
      queryParameters: queryP,
    );
    final result = await api.request(
      requestData: requestData,
      fromJsonT: Session.fromJson,
      withAuthToken: false,
    );
    BaseResponse data;
    try {
      data = BaseResponse.fromJson(result, (json) {
        if (json is List) {
          return Todo.froJsonList(json);
        }
      });
    } catch (e) {
      data = BaseResponse.fromJson(result, (_) {});
    }
    if (!data.ok) {
      GlobalLocator.appLogger.e(data.message);
      throw Exception(data.message);
    } else {
      return data.data;
    }
  }

  @override
  Future<bool?> updateStatus(bool status) async {
    final requestData = RequestData(
      path: '/task/update',
      method: Method.put,
      body: {'completed': status},
    );
    final result = await api.request(
      requestData: requestData,
      fromJsonT: Session.fromJson,
      withAuthToken: false,
    );
    BaseResponse data;
    try {
      data = BaseResponse.fromJson(result, (_) {});
    } catch (e) {
      data = BaseResponse.fromJson(result, (_) {});
    }
    if (!data.ok) {
      GlobalLocator.appLogger.e(data.message);
      throw Exception(data.message);
    } else {
      return data.ok;
    }
  }
}

/// Todo repository Riverpod instance
final todoRepository = Provider.autoDispose<ITodoRepository>(
  (ref) => TodoRepository(api: ref.read(apiProvider)),
);
