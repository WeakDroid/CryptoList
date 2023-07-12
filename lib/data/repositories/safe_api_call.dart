import 'package:dio/dio.dart';

import '../../domain/data_result/data_result.dart';
import 'api_exceptions.dart';

const String serverErrorMessage = "Server error occurred";

Future<DataResult<T>> safeApiCall<T>(
    {required DataResult<T> Function(dynamic) processedData,
    required Future<Response> Function() apiCall}) async {
  try {
    var response = await apiCall();
    _checkResponse(response);
    return processedData(response.data);

  } on ApiException catch (e) {
    return DataResult(
        error: Error(code: e.code, message: e.message ?? serverErrorMessage));
  } on Exception catch (e) {
    return DataResult(failure: Failure(exception: e));
  }
}

dynamic _checkResponse(Response response) {
  switch (response.statusCode) {
    case 201:
    case 200:
      return response;
    case 400:
    case 401:
    case 403:
    case 500:
    default:
      _throwApiException(response);
  }
}

void _throwApiException(Response response) {
  throw ApiException(response.statusCode, response.statusMessage);
}
