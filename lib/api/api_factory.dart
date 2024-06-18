import 'package:dio/dio.dart';
import 'package:seznam_blog/api/api_config.dart';
import 'package:seznam_blog/api/api_error_handler.dart';
import 'package:seznam_blog/api/api_result_handler.dart';
import 'package:seznam_blog/model/failure_response.dart';
import 'package:seznam_blog/model/success_response.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "contet-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class ApiFactory {
  Dio getDio() {
    Dio dio;

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
    };

    BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiConfig.API_URL,
      headers: headers,
    );

    dio = Dio(baseOptions);

    return dio;
  }

  Future<ApiResults> getMethod({
    required String endpoint,
    int? identificator,
  }) async {
    try {
      String path = endpoint;

      if (identificator != null) {
        path = "$path/$identificator";
      }

      var response = await getDio().get(endpoint);

      SuccessResponse successResponse = SuccessResponse.fromMap(response.data);

      return ApiSuccess(successResponse.data, response.statusCode);
    } on DioException catch (e) {
      if (e.response != null) {
        FailureResponse failureResponse = FailureResponse.fromMap(e.response!.data);

        return ApiFailure(failureResponse.code, failureResponse.message);
      } else {
        return ApiErrorHandler.handle(e).failure;
      }
    }
  }

  Future<ApiResults> postMethod({
    required String endpoint,
    int? identificator,
    Map<String, dynamic>? data,
  }) async {
    try {
      String path = endpoint;

      if (identificator != null) {
        path = "$path/$identificator";
      }

      var response = await getDio().post(
        path,
        data: data,
      );

      SuccessResponse successResponse = SuccessResponse.fromMap(response.data);

      return ApiSuccess(successResponse.data, response.statusCode);
    } on DioException catch (e) {
      if (e.response != null) {
        FailureResponse failureResponse = FailureResponse.fromMap(e.response!.data);

        return ApiFailure(failureResponse.code, failureResponse.message);
      } else {
        return ApiErrorHandler.handle(e).failure;
      }
    }
  }

  Future<ApiResults> putMethod({
    required String endpoint,
    int? identificator,
    Map<String, dynamic>? data,
  }) async {
    try {
      String path = endpoint;
      if (identificator != null) {
        path = "$endpoint/$identificator";
      }
      var response = await getDio().put(
        path,
        data: data,
      );

      SuccessResponse successResponse = SuccessResponse.fromMap(response.data);

      return ApiSuccess(successResponse.data, response.statusCode);
    } on DioException catch (e) {
      if (e.response != null) {
        FailureResponse failureResponse = FailureResponse.fromMap(e.response!.data);

        return ApiFailure(failureResponse.code, failureResponse.message);
      } else {
        return ApiErrorHandler.handle(e).failure;
      }
    }
  }

  Future<ApiResults> deleteMethod({
    required String endpoint,
    int? identificator,
    Map<String, dynamic>? data,
  }) async {
    try {
      String path = endpoint;
      if (identificator != null) {
        path = "$endpoint/$identificator";
      }
      var response = await getDio().delete(
        path,
        data: data,
      );

      SuccessResponse successResponse = SuccessResponse.fromMap(response.data);

      return ApiSuccess(successResponse.data, response.statusCode);
    } on DioException catch (e) {
      if (e.response != null) {
        FailureResponse failureResponse = FailureResponse.fromMap(e.response!.data);

        return ApiFailure(failureResponse.code, failureResponse.message);
      } else {
        return ApiErrorHandler.handle(e).failure;
      }
    }
  }
}
