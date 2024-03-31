import 'package:smartpay/app/service/auth/i_auth_service.dart';

mixin HomeProvider {
  Future<String> dashboard({
    required String token,
  }) async {
    return await IAuthService.instance.dashboard(token: token);
  }
}
