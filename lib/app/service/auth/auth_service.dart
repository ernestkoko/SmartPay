import 'dart:convert';
import 'dart:io';

import 'package:smartpay/app/model/auth/email_token_model.dart';
import 'package:smartpay/app/model/auth/reg.dart';
import 'package:smartpay/app/model/auth/verify_email-token.dart';
import 'package:smartpay/app/model/dashboard.dart';
import 'package:smartpay/app/service/auth/i_auth_service.dart';
import 'package:smartpay/app/service/base_service.dart';

class AuthService with BaseRequest implements IAuthService {
  @override
  Future<RegModel> register({
    required String name,
    String? userName,
    required String email,
    required String country,
    required String password,
  }) async {
    final map = {
      "full_name": name,
      "email": email,
      "country": country.toUpperCase(),
      "password": password,
      "device_name": 'mobile',
    };
    if (userName != null) {
      map['username'] = userName;
    }

    final response = await request(
      serviceUrl: 'auth/register',
      body: map,
      type: HttpRequestType.post,
    );
    final data = RegModel.fromJson(jsonDecode(response.body));
    return data;
  }

  @override
  Future<EmailTokenModel> getEmailToken({
    required String email,
  }) async {
    final map = {'email': email};
    final response = await request(
      serviceUrl: 'auth/email',
      body: map,
      type: HttpRequestType.post,
    );
    final data = EmailTokenModel.fromJson(jsonDecode(response.body));
    return data;
  }

  @override
  Future<VerifyEmailTokenModel> verifyEmailToken({
    required String email,
    required String token,
  }) async {
    final map = {
      'email': email,
      "token": token,
    };
    final response = await request(
      serviceUrl: 'auth/email/verify',
      body: map,
      type: HttpRequestType.post,
    );
    final data = VerifyEmailTokenModel.fromJson(jsonDecode(response.body));
    return data;
  }

  @override
  Future<RegModel> login({
    required String email,
    required String password,
  }) async {
    final map = {
      'email': email.trim().toLowerCase(),
      'password': password,
      'device_name': 'mobile'
    };
    final response = await request(
      serviceUrl: 'auth/login',
      body: map,
      type: HttpRequestType.post,
    );
    final data = RegModel.fromJson(jsonDecode(response.body));
    if (data.data!.token == null) {
      throw const HttpException(
          "Something went wrong with. Please try again later");
    }
    return data;
  }

  @override
  Future<String> dashboard({
    required String token,
  }) async {
    final response = await request(
      serviceUrl: 'dashboard',
      token: token,
      type: HttpRequestType.get,
    );
    return Dashboard.fromJson(jsonDecode(response.body)).data!.secret ??
        "Very unfortunate that nothing was returned";
  }
}
