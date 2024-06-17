/// Class to manage RequestDatas data
///
/// QueryParams could be added optionally
class RequestData {
  /// Class constructor
  RequestData({
    required this.path,
    this.queryParameters,
    this.body = const {},
    this.headers = const {},
    this.method = Method.get,
  });

  /// RequestData unencoded path
  final String path;

  /// RequestData method
  final String method;

  /// RequestData query Params
  final Map<String, dynamic>? queryParameters;

  /// RequestData body
  final Map<String, dynamic> body;

  /// RequestData headers
  final Map<String, String> headers;
}

/// Http request method
class Method {
  /// Http GET method
  static const String get = 'GET';

  /// Http POST method
  static const String post = 'POST';

  /// Http DELETE method
  static const String delete = 'DELETE';

  /// Http Update method
  static const String update = 'UPDATE';

  /// Http PUT method
  static const String put = 'PUT';
}
