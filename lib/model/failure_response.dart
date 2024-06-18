import 'dart:convert';

class FailureResponse {
  String status;
  int code;
  String message;

  FailureResponse({
    required this.status,
    required this.code,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'code': code,
      'message': message,
    };
  }

  factory FailureResponse.fromMap(Map<String, dynamic> map) {
    return FailureResponse(
      status: map['status'],
      code: map['code']?.toInt(),
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FailureResponse.fromJson(String source) => FailureResponse.fromMap(json.decode(source));
}
