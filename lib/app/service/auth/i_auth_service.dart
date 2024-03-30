import 'package:smartpay/app/model/auth/email_token_model.dart';
import 'package:smartpay/app/model/auth/reg.dart';
import 'package:smartpay/app/model/auth/verify_email-token.dart';
import 'package:smartpay/app/service/auth/auth_service.dart';

interface class IAuthService {
  static final IAuthService _instance = AuthService();

  static IAuthService get instance => _instance;

  Future<EmailTokenModel> getEmailToken({
    required String email,
  }) {
    throw UnimplementedError('getEmailToken not implemented!');
  }

  Future<VerifyEmailTokenModel> verifyEmailToken({
    required String email,
    required String token,
  }) {
    throw UnimplementedError('verifyEmailToken not implemented!');
  }

  Future<RegModel> register({
    required String name,
    String? userName,
    required String email,
    required String country,
    required String password,
  }) {
    throw UnimplementedError('register not implemented!');
  }
  Future<RegModel> login({
    required String email,
    required String password,
  }) {
    throw UnimplementedError('login not implemented!');
  }
}
