import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  fieldRename: FieldRename.snake,
)

/// Manage API responses
///
/// Manage api responses parsing it into an object
class BaseResponse<T> {
  /// Constructor
  BaseResponse(
    this.message,
    this.data,
    this.ok,
  );

  /// Method to parse API response
  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);

  /// Bool to know if api request had a server error
  @JsonKey(name: 'ok', defaultValue: true)
  final bool ok;

  /// Var who contains api request message
  @JsonKey(name: 'message')
  final String? message;

  /// var who contains api response
  @JsonKey(name: 'data')
  final T? data;

  ///  ToJson method
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}
