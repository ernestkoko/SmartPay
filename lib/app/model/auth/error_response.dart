class ErrorResponse {
  bool? status;
  String? message;
  List<dynamic>? data;
  List<dynamic>? meta;
  Errors? errors;

  ErrorResponse({
    this.status,
    this.message,
    this.data,
    this.meta,
    this.errors,
  });

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool?;
    message = json['message'] as String?;
    data = json['data'] as List?;
    meta = json['meta'] as List?;
    errors = (json['errors'] as Map<String,dynamic>?) != null ? Errors.fromJson(json['errors'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['message'] = message;
    json['data'] = data;
    json['meta'] = meta;
    json['errors'] = errors?.toJson();
    return json;
  }
}

class Errors {
  List<String>? email;

  Errors({
    this.email,
  });

  Errors.fromJson(Map<String, dynamic> json) {
    email = (json['email'] as List?)?.map((dynamic e) => e as String).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['email'] = email;
    return json;
  }
}