import 'package:flutter/material.dart';
import 'package:smartpay/app/module/home/home.dart';
import 'package:smartpay/app/module/onboard/onboard.dart';

import 'package:smartpay/app/route/route.dart';

import '../module/login/view/login.dart';
import '../module/reg/view/reg.dart';

abstract class AppPage {
  static get generateRoue => (RouteSettings setting) {
        if (setting.name == AppRoute.regPage) {
          return PageRouteBuilder(
            pageBuilder: (context, p, s) => const RegPage(),
          );
        }
        if (setting.name == AppRoute.loginPage) {
          return PageRouteBuilder(
            pageBuilder: (context, p, s) => const LoginPage(),
          );
        }
        if (setting.name == AppRoute.homePage) {
          final token = setting.arguments.toString();
          return PageRouteBuilder(
            pageBuilder: (context, p, s) => HomePage(
              token: token,
            ),
          );
        }
        if (setting.name == AppRoute.onboardPage) {
          return PageRouteBuilder(
            pageBuilder: (context, p, s) => const OnboardPage(),
          );
        }
      };
}
