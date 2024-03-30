class EmailTokenModel {
  bool? status;
  String? message;
  Data? data;

  EmailTokenModel({
    this.status,
    this.message,
    this.data,
  });

  EmailTokenModel.fromJson(Map<String, dynamic> json) {
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
  String? token;

  Data({
    this.token,
  });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['token'] = token;
    return json;
  }
}