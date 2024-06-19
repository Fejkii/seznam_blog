import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:seznam_blog/api/api_result_handler.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNATUHORIZED,
  CONFLICT,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

class ApiErrorHandler implements Exception {
  late ApiFailure failure;

  ApiErrorHandler.handle(dynamic error) {
    if (kDebugMode) {
      print("Error handler: $error");
    }
    if (error is DioException) {
      // error from response of the API
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

ApiFailure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECEIVE_TIMEOUT.getFailure();
    case DioExceptionType.badResponse:
      switch (error.response!.statusCode) {
        case ResponseCode.BAD_REQUEST:
          return DataSource.BAD_REQUEST.getFailure();
        case ResponseCode.FORBIDDEN:
          return DataSource.FORBIDDEN.getFailure();
        case ResponseCode.UNATUHORIZED:
          return DataSource.UNATUHORIZED.getFailure();
        case ResponseCode.CONFLICT:
          return DataSource.CONFLICT.getFailure();
        case ResponseCode.NOT_FOUND:
          return DataSource.NOT_FOUND.getFailure();
        case ResponseCode.INTERNAL_SERVER_ERROR:
          return DataSource.INTERNAL_SERVER_ERROR.getFailure();
        default:
          return DataSource.DEFAULT.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.DEFAULT.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.DEFAULT.getFailure();
    case DioExceptionType.unknown:
      return DataSource.DEFAULT.getFailure();
  }
}

extension DataSourceExtension on DataSource {
  ApiFailure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return ApiFailure(message: ResponseMessage.BAD_REQUEST, code: ResponseCode.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return ApiFailure(message: ResponseMessage.FORBIDDEN, code: ResponseCode.FORBIDDEN);
      case DataSource.UNATUHORIZED:
        return ApiFailure(message: ResponseMessage.UNATUHORIZED, code: ResponseCode.UNATUHORIZED);
      case DataSource.CONFLICT:
        return ApiFailure(message: ResponseMessage.CONFLICT, code: ResponseCode.CONFLICT);
      case DataSource.NOT_FOUND:
        return ApiFailure(message: ResponseMessage.NOT_FOUND, code: ResponseCode.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return ApiFailure(message: ResponseMessage.INTERNAL_SERVER_ERROR, code: ResponseCode.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return ApiFailure(message: ResponseMessage.CONNECT_TIMEOUT, code: ResponseCode.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return ApiFailure(message: ResponseMessage.CANCEL, code: ResponseCode.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return ApiFailure(message: ResponseMessage.RECEIVE_TIMEOUT, code: ResponseCode.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return ApiFailure(message: ResponseMessage.SEND_TIMEOUT, code: ResponseCode.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return ApiFailure(message: ResponseMessage.CACHE_ERROR, code: ResponseCode.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return ApiFailure(message: ResponseMessage.NO_INTERNET_CONNECTION, code: ResponseCode.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return ApiFailure(message: ResponseMessage.DEFAULT, code: ResponseCode.DEFAULT);
      default:
        return ApiFailure(message: ResponseMessage.DEFAULT, code: ResponseCode.DEFAULT);
    }
  }
}

class ResponseCode {
  // API code
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // succes with no content
  static const int BAD_REQUEST = 400; // API rejected the request
  static const int FORBIDDEN = 403; // API rejected the request
  static const int UNATUHORIZED = 401; // failures user is not authorised
  static const int NOT_FOUND = 404; // API URL is not correct. not found
  static const int CONFLICT = 409; // This response is sent when a request conflicts with the current state of the server.
  static const int INTERNAL_SERVER_ERROR = 500; // crash happend in server side

  // local status code
  static const int DEFAULT = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  // API code
  static const String SUCCESS = "Success"; // success with data
  static const String NO_CONTENT = "Succes with no content"; // succes with no content
  static const String BAD_REQUEST = "Bad request, try again later"; // API rejected the request
  static const String FORBIDDEN = "Forbidden request, try again later"; // API rejected the request
  static const String UNATUHORIZED = "User is not authorised"; // failures user is not authorised
  static const String NOT_FOUND = "URL is not correct, try again later"; // API URL is not correct, not found
  static const String CONFLICT = "Some conflict with data on server"; // Probably iteam is already exist
  static const String INTERNAL_SERVER_ERROR = "Internal server error, try again later"; // crash happend in server side

  // local status code
  static const String DEFAULT = "Some thing went wrong, try again later";
  static const String CONNECT_TIMEOUT = "Connection time out error, try again later";
  static const String CANCEL = "Request was cancelled";
  static const String RECEIVE_TIMEOUT = "Receiving time out error";
  static const String SEND_TIMEOUT = "Sending time out error";
  static const String CACHE_ERROR = "Cache error";
  static const String NO_INTERNET_CONNECTION = "No internet connection";
}
