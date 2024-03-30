import 'package:smartpay/app/model/auth/email_token_model.dart';
import 'package:smartpay/app/model/auth/reg.dart';
import 'package:smartpay/app/model/auth/verify_email-token.dart';
import 'package:smartpay/app/service/auth/i_auth_service.dart';

mixin RegProvider {
  Future<EmailTokenModel> getEmailToken({
    required String email,
  }) async {
    return await IAuthService.instance.getEmailToken(email: email);
  }

  Future<VerifyEmailTokenModel> verifyEmailToken({
    required String email,
    required String token,
  }) async {
    return await IAuthService.instance.verifyEmailToken(email: email, token: token);
  }

  Future<RegModel> register({
    required String name,
    String? userName,
    required String email,
    required String country,
    required String password,
  }) async {
    return await IAuthService.instance.register(
      name: name,
      email: email,
      country: country,
      password: password,
    );
  }
}
