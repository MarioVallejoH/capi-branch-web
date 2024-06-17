import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:web/src/data/entities/request_data.dart';
import 'package:web/src/utils/utils.dart';

/// Class to perform API calls
class ApiDataSource {
  /// Api request constructor
  ApiDataSource() {
    // Read it from ENV vars
    //_http.options.baseUrl =
    //    const String.fromEnvironment('HOST', defaultValue: '');
    _http.options.baseUrl = 'http://192.168.1.109:3000';
  }

  /// Headers
  static final Map<String, String> _headers = {};

  final _http = Dio();
  final _logger = GlobalLocator.appLogger;

  /// Method to check internet connection and set headers
  Future<void> _requestData(
    bool withAuthToken, {
    bool formData = false,
  }) async {
    if (formData) {
      _headers['Content-type'] = 'multipart/form-data';
    } else {
      _headers['Content-type'] = 'application/json';
    }
    _headers['Accept'] = '*/*';
    if (withAuthToken) {
      try {
        const storage = FlutterSecureStorage();
        final token = await storage.read(key: 'accessToken') ?? '';
        if (token.isNotEmpty) {
          _headers['Authorization'] = 'Bearer $token';
        }
      } catch (e) {
        log(e);
      }
    } else {
      _headers.remove('Authorization');
    }
    try {
      _headers['X-Platform'] = Platform.isIOS ? 'ios' : 'android';
    } catch (e) {
      _logger.d(e);
    }
    _http.options.headers = _headers;
  }

  Future<dynamic> _httpRequest(
    Future<dynamic> Function() request,
  ) async {
    return await request.call().timeout(
          const Duration(seconds: 30),
        );
  }

  static Map<String, dynamic> _resolveInternalError(dynamic e) {
    return {
      'ok': false,
      'message': '${AppMessages.internalError}$e',
      'error': true,
      'data': [],
    };
  }

  static Map<String, dynamic> _resolveServerErrorCode(DioException e) {
    return {
      'message': '${e.response?.data['message'] ?? e.message}',
      'ok': false,
      'data': {},
    };
  }

  /// Perform any http-https request with a given [RequestData]
  Future<Map<String, dynamic>> request({
    required RequestData requestData,
    bool withAuthToken = true,
    dynamic Function(Object?)? fromJsonT,
  }) async {
    if (!(await isNetworkAvailable())) {
      Fluttertoast.cancel();
      toast(AppMessages.noInternetConnection);
      return {
        'ok': false,
        'message': AppMessages.noInternetConnection,
        'data': [],
      };
    }
    await _requestData(withAuthToken);
    _logger.d('Request endpoint: ${requestData.body}');
    _headers.addAll(requestData.headers);
    dynamic data;
    try {
      switch (requestData.method) {
        case Method.get:
          data = await get(
            requestData.path,
            queryParameters: requestData.queryParameters,
          );
          break;
        case Method.post:
          data = await post(
            requestData.path,
            requestData.body,
            queryParameters: requestData.queryParameters,
          );
          break;
        case Method.put:
          data = await put(
            requestData.path,
            requestData.body,
            queryParameters: requestData.queryParameters,
          );
          break;
        case Method.delete:
          data = await delete(
            requestData.path,
            queryParameters: requestData.queryParameters,
          );
          break;
        default:
          return {
            'ok': false,
            'message': 'El método de comunicación http no fue encontrado.',
            'data': [],
          };
      }
    } on DioException catch (e) {
      data = _resolveServerErrorCode(e);
    } on Exception catch (e) {
      data = _resolveInternalError(e);
    }
    return data;
  }

  /// Perform API GET operations
  Future<dynamic> get(
    String endpoint, {
    bool withAuthToken = true,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _httpRequest(
      () async {
        try {
          _logger.d('get() to ($endpoint) - headers ($_headers)');

          final response = await _http.get(
            endpoint,
            queryParameters: queryParameters,
          );
          return response.data;
        } on DioException catch (e) {
          GlobalLocator.appLogger.e(e);
          rethrow;
        } on Exception catch (e) {
          return _resolveInternalError(e);
        }
      },
    );
  }

  /// Perform API POST operations
  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _httpRequest(
      () async {
        try {
          /// Used for test purposes
          _logger
              .d('post() to ($endpoint) - headers ($_headers) with data $data');
          final response = await _http.post(
            endpoint,
            data: data,
            queryParameters: queryParameters,
          );
          return response.data;
        } on DioException catch (e) {
          _logger.e(e.message);
          rethrow;
        } on Exception catch (e) {
          return _resolveInternalError(e);
        }
      },
    );
  }

  /// Perform API POST form data operations
  Future<dynamic> postFormData(
    String endpoint,
    Map<String, dynamic> data, {
    bool withAuthToken = true,
    String? filePath,
    String? fileKey,
    String? fileName,
  }) async {
    return await _httpRequest(
      () async {
        await _requestData(
          withAuthToken,
          formData: true,
        );
        try {
          if (filePath != null && fileKey != null) {
            if (fileName != null) {
              data[fileKey] = await MultipartFile.fromFile(
                filePath,
                filename: fileName,
              );
            } else {
              data[fileKey] = await MultipartFile.fromFile(
                filePath,
              );
            }
          }
          var formData = FormData.fromMap(data);
          final response = await _http.post(
            endpoint,
            data: formData,
          );
          return response.data;
        } on DioException {
          rethrow;
        } on Exception catch (e) {
          return _resolveInternalError(e);
        }
      },
    );
  }

  /// Perform API PUT operations
  Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> data, {
    bool withAuthToken = true,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _httpRequest(
      () async {
        try {
          _logger
              .d('put() to ($endpoint) - headers ($_headers) with data $data');
          final response = await _http.put(
            endpoint,
            data: data,
            queryParameters: queryParameters,
          );
          return response.data;
        } on DioException {
          rethrow;
        } on Exception catch (e) {
          _logger.i(endpoint);
          _logger.e(e);
          return _resolveInternalError(e);
        }
      },
    );
  }

  /// Perform API DELETE operations
  Future<dynamic> delete(
    String endpoint, {
    bool withAuthToken = true,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _httpRequest(
      () async {
        try {
          _logger.d('delete() to ($endpoint) - headers ($_headers)');
          final response = await _http.delete(
            endpoint,
            queryParameters: queryParameters,
          );
          return response.data;
        } on DioException {
          rethrow;
        } on Exception catch (e) {
          return _resolveInternalError(e);
        }
      },
    );
  }
}

/// Api provider riverpod instance
final apiProvider =
    Provider.autoDispose<ApiDataSource>((ref) => ApiDataSource());
