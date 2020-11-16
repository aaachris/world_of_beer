import 'package:dio/dio.dart';

String errorTextUi(dynamic error) {
  if (error is DioError) {
    return "${error.response.statusMessage} (Code: ${error.response.statusCode})";
  }
  return null;
}
