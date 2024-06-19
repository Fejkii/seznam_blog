import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:seznam_blog/api/api_config.dart';
import 'package:seznam_blog/api/api_error_handler.dart';
import 'package:seznam_blog/api/api_result_handler.dart';

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

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );

    return dio;
  }

  Future<ApiResultHandler> getMethod({
    required String endpoint,
    int? identificator,
    String? param,
  }) async {
    try {
      String path = endpoint;

      if (identificator != null) {
        path = "$path/$identificator";
      }

      if (param != null && param != "") {
        path = "$path/$param";
      }

      path = ApiConfig.API_URL + path;

      var response = await getDio().get(path);

      return ApiSuccess(data: response.data, code: response.statusCode);
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiFailure(message: e.response.toString(), code: e.response?.statusCode);
      } else {
        return ApiErrorHandler.handle(e).failure;
      }
    }
  }

  Future<ApiResultHandler> postMethod({
    required String endpoint,
    int? identificator,
    Map<String, dynamic>? data,
  }) async {
    try {
      String path = endpoint;

      if (identificator != null) {
        path = path + identificator.toString();
      }

      path = ApiConfig.API_URL + path;

      var response = await getDio().post(
        path,
        data: data,
      );

      return ApiSuccess(data: response.data, code: response.statusCode);
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiFailure(message: e.response.toString(), code: e.response?.statusCode);
      } else {
        return ApiErrorHandler.handle(e).failure;
      }
    }
  }

  Future<ApiResultHandler> putMethod({
    required String endpoint,
    int? identificator,
    Map<String, dynamic>? data,
  }) async {
    try {
      String path = endpoint;

      if (identificator != null) {
        path = path + identificator.toString();
      }

      path = ApiConfig.API_URL + path;

      var response = await getDio().put(
        path,
        data: data,
      );

      return ApiSuccess(data: response.data, code: response.statusCode);
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiFailure(message: e.response.toString(), code: e.response?.statusCode);
      } else {
        return ApiErrorHandler.handle(e).failure;
      }
    }
  }

  Future<ApiResultHandler> deleteMethod({
    required String endpoint,
    int? identificator,
    Map<String, dynamic>? data,
  }) async {
    try {
      String path = endpoint;

      if (identificator != null) {
        path = path + identificator.toString();
      }

      path = ApiConfig.API_URL + path;

      var response = await getDio().delete(
        path,
        data: data,
      );

      return ApiSuccess(data: response.data, code: response.statusCode);
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiFailure(message: e.response.toString(), code: e.response?.statusCode);
      } else {
        return ApiErrorHandler.handle(e).failure;
      }
    }
  }
}
