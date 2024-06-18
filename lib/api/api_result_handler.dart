abstract class ApiResults {}

class ApiSuccess extends ApiResults {
  int code;
  dynamic data;

  ApiSuccess(
    this.code,
    this.data,
  );
}

class ApiFailure extends ApiResults {
  int code;
  String message;

  ApiFailure(
    this.code,
    this.message,
  );
}
