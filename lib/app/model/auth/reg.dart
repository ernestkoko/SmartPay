class RegModel {
  bool? status;
  String? message;
  Data? data;
  List<dynamic>? meta;
  List<dynamic>? pagination;

  RegModel({
    this.status,
    this.message,
    this.data,
    this.meta,
    this.pagination,
  });

  RegModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  String? token;

  Data({
    this.user,
    this.token,
  });

  Data.fromJson(Map<String, dynamic> json) {
    user = (json['user'] as Map<String,dynamic>?) != null ? User.fromJson(json['user'] as Map<String,dynamic>) : null;
    token = json['token'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['user'] = user?.toJson();
    json['token'] = token;
    return json;
  }
}

class User {
  String? fullName;
  String? username;
  String? email;
  String? country;
  String? id;

  User({
    this.fullName,
    this.username,
    this.email,
    this.country,
    this.id,
  });

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'] as String?;
    username = json['username'] as String?;
    email = json['email'] as String?;
    country = json['country'] as String?;
    id = json['id'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['full_name'] = fullName;
    json['username'] = username;
    json['email'] = email;
    json['country'] = country;
    json['id'] = id;
    return json;
  }
}