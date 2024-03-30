import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartpay/app/animations/slide.dart';
import 'package:smartpay/app/asset/image.dart';
import 'package:smartpay/app/module/reg/bloc/reg_bloc.dart';
import 'package:smartpay/app/route/app_route.dart';

import 'package:smartpay/app/util/extension.dart';
import 'package:smartpay/app/widgets/button.dart';
import 'package:smartpay/app/widgets/code_box.dart';
import 'package:smartpay/app/widgets/divider.dart';
import 'package:smartpay/app/widgets/keypad.dart';
import 'package:smartpay/app/widgets/snackbar.dart';
import 'package:smartpay/app/widgets/text.dart';
import 'package:smartpay/app/widgets/text_field.dart';

class RegPage extends StatelessWidget {
  const RegPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RegBloc, RegState>(
          listener: (context, state) {
            if (state is RegErrorState) {
              showAppSnackBar(context,
                  message: state.message,
                  messageType: SnackBarMessageType.error);
            }
            if (state is RegPageChangesState && state.showSnack) {
              showAppSnackBar(context,
                  message: 'Successful!',
                  messageType: SnackBarMessageType.success);
            }
          },
          builder: (context, state) {
            final bloc = context.read<RegBloc>();
            return AppSlideAnimation(
              beginOffset: state is RegInitState && state.animate
                  ? Offset(-0.1, -0.15)
                  : null,
              milliseconds: 2500,
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (bloc.regPageState != RegPageState.registered)
                          AppBackButton(
                            onTap: state is RegLoadingState && state.loading
                                ? () {}
                                : () {
                                    if (bloc.regPageState == RegPageState.pin) {
                                      bloc.add(OnRegPageChangedEvent(
                                          page: RegPageState.details,
                                          backward: true));
                                    } else if (bloc.regPageState ==
                                        RegPageState.details) {
                                      bloc.add(OnRegPageChangedEvent(
                                          page: RegPageState.verify,
                                          backward: true));
                                    } else if (bloc.regPageState ==
                                        RegPageState.verify) {
                                      bloc.add(OnRegPageChangedEvent(
                                          page: RegPageState.reg,
                                          backward: true));
                                    }
                                  },
                          ),
                      ],
                    ),
                    40.verticalSpace,
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          if (bloc.regPageState == RegPageState.reg)
                            ..._regState(context, bloc: bloc, state: state),
                          if (bloc.regPageState == RegPageState.verify)
                            ..._verifyState(context, bloc: bloc, state: state),
                          if (bloc.regPageState == RegPageState.details)
                            ..._details(context, bloc: bloc, state: state),
                          if (bloc.regPageState == RegPageState.pin)
                            ..._pin(context, bloc: bloc, state: state),
                          if (bloc.regPageState == RegPageState.registered)
                            ..._registered(context, bloc: bloc),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _regState(
    BuildContext context, {
    required RegBloc bloc,
    required RegState state,
  }) {
    return [
      RichText(
        text: TextSpan(
          text: 'Create a ',
          style: Theme.of(context).textTheme.headlineMedium,
          children: [
            TextSpan(
              text: "Smartpay",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const TextSpan(
              text: "\naccount",
            )
          ],
        ),
      ),
      20.verticalSpace,
      AppTextField(
        hintText: "Email",
        controller: bloc.emailController,
        keyboardType: TextInputType.emailAddress,
        onChanged: (v) {
          bloc.add(OnAddCodeRegEvent());
        },
      ),
      20.verticalSpace,
      AppButton1(
        title: 'Sign Up',
        active: bloc.emailController.text.isNotEmpty,
        loading: state is RegLoadingState && state.loading,
        onPressed: () {
          bloc.add(OnRegPageChangedEvent(page: RegPageState.verify));
        },
      ),
      30.verticalSpace,
      const AppDivider(),
      30.verticalSpace,
      ThirdPartySignInButtons(
        onTap1: () {},
      ),
      90.verticalSpace,
      Center(
        child: AppClickText(
          text1: 'Already have an account? ',
          clickText: "Sign In",
          onTap: () {
            Navigator.of(context).pushNamed(AppRoute.loginPage);
          },
        ),
      )
    ];
  }

  List<Widget> _verifyState(
    BuildContext context, {
    required RegBloc bloc,
    required RegState state,
  }) {
    return [
      Text('Verify it\'s you',
          style: Theme.of(context).textTheme.headlineMedium),
      10.verticalSpace,
      RichText(
        text: TextSpan(
          text: 'We sent a code to ( ',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .color!
                  .withOpacity(0.6)),
          children: [
            TextSpan(
              text: '*****@${bloc.emailController.text.split('@')[1]}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const TextSpan(text: ' ). Enter it here to verify your identity'),
          ],
        ),
      ),
      30.verticalSpace,
      CodeBox(
        list: bloc.codeList,
      ),
      35.verticalSpace,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Resend code in 30 secs',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 16,
                height: 1.5,
                color: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .color!
                    .withOpacity(0.6)),
          ),
        ],
      ),
      60.verticalSpace,
      AppButton1(
        title: "Confirm",
        active: bloc.codeList.length == 5,
        loading: state is RegLoadingState && state.loading,
        onPressed: () {
          bloc.add(OnRegPageChangedEvent(page: RegPageState.details));
        },
      ),
      40.verticalSpace,
      AppKeypad(
        onAdd: (v) {
          bloc.add(OnAddCodeRegEvent(value: v));
        },
        onDelete: () {
          bloc.add(OnRemoveCodeRegEvent(page: RegPageState.verify));
        },
      ),
    ];
  }

  List<Widget> _details(BuildContext context,
      {required RegBloc bloc, required RegState state}) {
    return [
      RichText(
        text: TextSpan(
          text: 'Hey there! Tell us a bit\nabout ',
          style: Theme.of(context).textTheme.headlineLarge,
          children: [
            TextSpan(
              text: "yourself",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
      ),
      20.verticalSpace,
      AppTextField(
        hintText: "Full name",
        keyboardType: TextInputType.name,
        controller: bloc.nameController,
        onChanged: (v) {
          bloc.add(OnAddCodeRegEvent());
        },
      ),
      20.verticalSpace,
      AppTextField(
        hintText: "Username",
        keyboardType: TextInputType.text,
        controller: bloc.userNameController,
        onChanged: (v) {
          bloc.add(OnAddCodeRegEvent());
        },
      ),
      20.verticalSpace,
      AppTextField(
        hintText: "Select County",
        keyboardType: TextInputType.name,
        controller: bloc.countryController,
        onChanged: (v) {
          bloc.add(OnAddCodeRegEvent());
        },
      ),
      20.verticalSpace,
      AppTextField(
        hintText: "Password",
        keyboardType: TextInputType.text,
        controller: bloc.passwordController,
        password: true,
        onChanged: (v) {
          bloc.add(OnAddCodeRegEvent());
        },
      ),
      40.verticalSpace,
      AppButton1(
        title: 'Continue',
        active: bloc.nameController.text.isNotEmpty &&
            bloc.countryController.text.isNotEmpty &&
            bloc.passwordController.text.isNotEmpty,
        loading: state is RegLoadingState && state.loading,
        onPressed: () {
          bloc.add(OnRegPageChangedEvent(page: RegPageState.pin));
        },
      ),
    ];
  }

  List<Widget> _pin(BuildContext context,
      {required RegBloc bloc, required RegState state}) {
    return [
      Text(
        'Set your PIN code',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      10.verticalSpace,
      Text(
        'We use state-of-the-art security measures to protect your account att all times',
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: const Color(0xFF6B7280)),
      ),
      30.verticalSpace,
      CodeBox(
        list: bloc.pinList,
        pin: true,
      ),
      100.verticalSpace,
      AppButton1(
        title: "Create PIN",
        active: bloc.pinList.length == 5,
        loading: state is RegLoadingState && state.loading,
        onPressed: () {
          bloc.add(OnRegPageChangedEvent(page: RegPageState.registered));
        },
      ),
      40.verticalSpace,
      AppKeypad(
        onAdd: (v) {
          bloc.add(OnAddCodeRegEvent(pin: v));
        },
        onDelete: () {
          bloc.add(OnRemoveCodeRegEvent(page: RegPageState.pin));
        },
      ),
    ];
  }

  List<Widget> _registered(BuildContext context, {required RegBloc bloc}) {
    return [
      (MediaQuery.of(context).size.height * 0.20).verticalSpace,
      AppSlideAnimation(
        beginOffset: Offset(-1.6, -2.0),
        child: Image.asset(
          AppAsset.congrats,
          height: 134,
        ),
      ),
      50.verticalSpace,
      AppSlideAnimation(
        beginOffset: Offset(-2.0, -20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congratulations, ${bloc.nameController.text.split(' ')[0]} ',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      20.verticalSpace,
      AppSlideAnimation(
        beginOffset: Offset(-2.0, -20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You\'ve completed the onboarding, \nyou can start using',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: const Color(0xFF6B7280)),
            ),
          ],
        ),
      ),
      40.verticalSpace,
      AppSlideAnimation(
        beginOffset: Offset(0, -5.0),
        child: AppButton1(
          title: 'Get Started',
          active: true,
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoute.loginPage);
          },
        ),
      )
    ];
  }
}
