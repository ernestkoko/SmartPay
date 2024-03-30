class VerifyEmailTokenModel {
  bool? status;
  String? message;
  Data? data;

  VerifyEmailTokenModel({
    this.status,
    this.message,
    this.data,
  });

  VerifyEmailTokenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool?;
    message = json['message'] as String?;
    data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['message'] = message;
    json['data'] = data?.toJson();
    return json;
  }
}

class Data {
  String? email;

  Data({
    this.email,
  });

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['email'] = email;
    return json;
  }
}