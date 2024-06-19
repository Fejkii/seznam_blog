abstract class ApiResultHandler {}

class ApiSuccess extends ApiResultHandler {
  dynamic data;
  int? code;

  ApiSuccess({
    required this.data,
    this.code,
  });
}

class ApiFailure extends ApiResultHandler {
  String message;
  int? code;

  ApiFailure({
    required this.message,
    this.code,
  });
}
