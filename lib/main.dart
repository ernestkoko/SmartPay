import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartpay/app/constants.dart';
import 'package:smartpay/app/module/home/bloc/home_bloc.dart';
import 'package:smartpay/app/module/login/bloc/login_bloc.dart';
import 'package:smartpay/app/module/onboard/bloc/onboard_bloc.dart';

import 'package:smartpay/app/route/route.dart';

import 'app/module/reg/reg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnboardBloc>(
          create: (_) => OnboardBloc()..add(OnInitOnboardEvent()),
        ),
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc()..add(OnInitLoginEvent()),
        ),
        BlocProvider<RegBloc>(
          create: (_) => RegBloc()..add(OnInitRegEvent()),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc()..add(OnInitHomeEvent()),
        ),
      ],
      child: MaterialApp(
        key: scaffoldKey,
        title: 'Smart Pay',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            primary: const Color(0xFF0A6375),
          ),
          useMaterial3: true,
          textTheme: const TextTheme(
            bodySmall: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF111827)),
            bodyLarge: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              height: 1.3,
              color: Color(0xFF111827),
            ),
            headlineSmall: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 1.5,
              color: Color(0xFF111827),
            ),
            headlineMedium: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              height: 1.3,
              color: Color(0xFF111827),
            ),
            headlineLarge: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              height: 1.3,
              color: Color(0xFF111827),
            ),
          ),
        ),
        initialRoute: AppRoute.onboardPage,
        onGenerateRoute: AppPage.generateRoue,
      ),
    );
  }
}
