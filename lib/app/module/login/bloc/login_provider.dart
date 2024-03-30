import 'package:smartpay/app/model/auth/reg.dart';
import 'package:smartpay/app/service/auth/i_auth_service.dart';

mixin LoginProvider {
  Future<RegModel> login({
    required String email,
    required String password,
  }) async {
    return await IAuthService.instance.login(email: email, password: password);
  }
}
