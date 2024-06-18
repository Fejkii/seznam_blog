import 'dart:convert';

class SuccessResponse {
  String status;
  int code;
  String message;
  dynamic data;

  SuccessResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'data': data,
    };
  }

  factory SuccessResponse.fromMap(Map<String, dynamic> map) {
    return SuccessResponse(
      status: map['status'],
      code: map['code']?.toInt(),
      message: map['message'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SuccessResponse.fromJson(String source) => SuccessResponse.fromMap(json.decode(source));
}
