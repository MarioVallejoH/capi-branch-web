import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web/src/data/data_sources/api_datasource.dart';
import 'package:web/src/data/entities/entities.dart';
import 'package:web/src/domain/dtos/dtos.dart';
import 'package:web/src/domain/repositories/user_repository.dart';
import 'package:web/src/utils/utils.dart';

/// Implementation for UserRepository using APIDataSource
class UserRepository implements IUserRepository {
  /// Repository constructor
  UserRepository({required this.api});

  /// APiDataSource object
  final ApiDataSource api;

  @override
  Future<Session> userLogin(UserLoginDTO login) async {
    final requestData = RequestData(
      path: '/auth/sign_in',
      method: Method.post,
      body: login.toJson(),
    );
    final result = await api.request(
      requestData: requestData,
      fromJsonT: Session.fromJson,
      withAuthToken: false,
    );
    BaseResponse data;
    try {
      data = BaseResponse.fromJson(result, Session.fromJson);
    } catch (e) {
      data = BaseResponse.fromJson(result, (_) {});
    }
    if (!data.ok) {
      GlobalLocator.appLogger.e(data.message);
      throw Exception(data.message);
    } else {
      setSessionData(data.data);
      return data.data;
    }
  }

  @override
  Future<void> logout() async {
    ///TODO: Perform logout on server side
    // final requestData = RequestData(
    //   path: 'auth/logout',
    //   method: Method.get,
    // );
    // final result = await api.request(
    //   requestData: requestData,
    //   fromJsonT: Session.fromJson,
    //   withAuthToken: true,
    // );
    // BaseResponse data;
    //   data = BaseResponse.fromJson(result, (_) {});
    await setSessionData(Session(
      accessToken: '',
    ));
  }

  @override
  Future<bool?> userRegister(RegisterDTO userData) async {
    final requestData = RequestData(
      path: '/auth/register',
      method: Method.post,
      body: userData.toJson(),
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
      throw Exception(data.message);
    } else {
      return data.ok;
    }
  }

  @override
  Future<void> setSessionData(Session? session) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'accessToken', value: session?.accessToken);
  }

  @override
  Future<User> getUserData() async {
    final requestData = RequestData(
      path: '/user/userData',
      method: Method.get,
    );
    final result = await api.request(
      requestData: requestData,
      withAuthToken: true,
    );
    BaseResponse data;
    try {
      data = BaseResponse.fromJson(result, User.fromJson);
    } catch (e) {
      data = BaseResponse.fromJson(result, (_) {});
    }
    if (!data.ok) {
      throw Exception(data.message);
    } else {
      return data.data;
    }
  }

  @override
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final requestData = RequestData(
      path: '/auth/changePassword',
      method: Method.put,
      body: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      },
    );
    final result = await api.request(
      requestData: requestData,
      withAuthToken: true,
    );
    BaseResponse data;
    try {
      data = BaseResponse.fromJson(result, (json) => json == true);
    } catch (e) {
      data = BaseResponse.fromJson(result, (_) {});
    }
    if (!data.ok) {
      throw Exception(data.message);
    } else {
      return data.data;
    }
  }
}

/// User repository Riverpod instance
final userRepository = Provider.autoDispose<IUserRepository>(
  (ref) => UserRepository(api: ref.read(apiProvider)),
);
