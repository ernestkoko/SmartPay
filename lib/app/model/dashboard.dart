class Dashboard {
  bool? status;
  String? message;
  Data? data;
  List<dynamic>? meta;
  List<dynamic>? pagination;

  Dashboard({
    this.status,
    this.message,
    this.data,
    this.meta,
    this.pagination,
  });

  Dashboard.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool?;
    message = json['message'] as String?;
    data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;
    meta = json['meta'] as List?;
    pagination = json['pagination'] as List?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['message'] = message;
    json['data'] = data?.toJson();
    json['meta'] = meta;
    json['pagination'] = pagination;
    return json;
  }
}

class Data {
  String? secret;

  Data({
    this.secret,
  });

  Data.fromJson(Map<String, dynamic> json) {
    secret = json['secret'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['secret'] = secret;
    return json;
  }
}