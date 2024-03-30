import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartpay/app/animations/slide.dart';
import 'package:smartpay/app/module/login/bloc/login_bloc.dart';
import 'package:smartpay/app/module/reg/bloc/reg_bloc.dart';
import 'package:smartpay/app/route/app_route.dart';
import 'package:smartpay/app/util/extension.dart';
import 'package:smartpay/app/widgets/button.dart';
import 'package:smartpay/app/widgets/divider.dart';
import 'package:smartpay/app/widgets/snackbar.dart';
import 'package:smartpay/app/widgets/text.dart';
import 'package:smartpay/app/widgets/text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginErrorState) {
                showAppSnackBar(context,
                    message: state.message,
                    messageType: SnackBarMessageType.error);
              }
              if (state is LoginSuccessState) {
                showAppSnackBar(context,
                    message: "Logged in successfully!",
                    messageType: SnackBarMessageType.success);
                Navigator.of(context)
                    .pushNamed(AppRoute.homePage, arguments: state.token);
              }
            },
            builder: (context, state) {
              final bloc = context.read<LoginBloc>();
              return Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppBackButton(
                          onTap: () {},
                        ),
                      ],
                    ),
                    30.verticalSpace,
                    Text("Hi There!👋",
                        style: Theme.of(context).textTheme.headlineMedium),
                    10.verticalSpace,
                    Text(
                      "Welcome back, Sign in to your account",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: const Color(0xFF6B7280)),
                    ),
                    40.verticalSpace,
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          AppTextField(
                            hintText: "Email",
                            controller: bloc.emailController,
                            enabled: state is LoginLoadingState && state.loading
                                ? false
                                : true,
                            onChanged: (v) {
                              bloc.add(OnLoginFieldChangedEvent());
                            },
                          ),
                          20.verticalSpace,
                          AppTextField(
                            hintText: "Password",
                            password: true,
                            controller: bloc.passwordController,
                            enabled: state is LoginLoadingState && state.loading
                                ? false
                                : true,
                            onChanged: (v) {
                              bloc.add(OnLoginFieldChangedEvent());
                            },
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  surfaceTintColor: Colors.transparent,
                                  foregroundColor: Colors.transparent,
                                ),
                                child: Text(
                                  "Forgot Password?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 16,
                                        height: 1.5,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          12.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: AppButton1(
                                  title: "Sign In",
                                  active: bloc
                                          .emailController.text.isNotEmpty &&
                                      bloc.passwordController.text.isNotEmpty,
                                  loading: state is LoginLoadingState &&
                                      state.loading,
                                  onPressed: () {
                                    bloc.add(OnLoginEvent());
                                  },
                                ),
                              ),
                            ],
                          ),
                          20.verticalSpace,
                          const AppDivider(),
                          15.verticalSpace,
                          ThirdPartySignInButtons(
                            onTap1: () {},
                            onTap2: () {},
                          ),
                        ],
                      ),
                    ),
                    Center(
                        child: AppClickText(
                      text1: "Don't have an account? ",
                      clickText: "Sign Up",
                      onTap: () {
                        context.read<RegBloc>().add(OnInitRegEvent());
                        Navigator.of(context).pushNamed(AppRoute.regPage);
                      },
                    )),
                    30.verticalSpace,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
