import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartpay/app/asset/image.dart';
import 'package:smartpay/app/module/onboard/bloc/onboard_bloc.dart';
import 'package:smartpay/app/route/app_route.dart';
import 'package:smartpay/app/util/extension.dart';
import 'package:smartpay/app/widgets/button.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
          child: BlocConsumer<OnboardBloc, OnboardState>(
              listener: (context, state) {},
              builder: (context, state) {
                final bloc = context.read<OnboardBloc>();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            //skip to login
                            Navigator.of(context).pushNamed(AppRoute.loginPage);
                          },
                          child: Text(
                            "Skip",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: const Color(0xFF2FA2B9),
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Image.asset(AppAsset.congrats),
                    ),
                    Text(
                      bloc.pageState == OnboardPageState.one
                          ? 'Finance app the safest and most trusted'
                          : "The fastest transaction process on here",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    20.verticalSpace,
                    Text(
                      bloc.pageState == OnboardPageState.one
                          ? 'Your finance work starts here. We are here to help you track and deal with speeding up your transactions.'
                          : 'Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: const Color(0xFF6B7280)),
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _dot(
                          context,
                          active: bloc.pageState == OnboardPageState.one,
                        ),
                        8.horizontalSpace,
                        _dot(
                          context,
                          active: bloc.pageState == OnboardPageState.two,
                        ),
                      ],
                    ),
                    50.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: AppButton1(
                            active: true,
                            title: 'Get Started',
                            onPressed: () {
                              if (bloc.pageState == OnboardPageState.one) {
                                bloc.add(OnNextOnboardEvent(
                                    pageState: OnboardPageState.two));
                              } else {
                                Navigator.of(context)
                                    .pushNamed(AppRoute.loginPage);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget _dot(
    BuildContext context, {
    bool active = false,
  }) {
    return Container(
      height: 8,
      width: active ? 50 : 8,
      decoration: BoxDecoration(
        color: active
            ? Theme.of(context).textTheme.headlineSmall!.color
            : Theme.of(context)
                .textTheme
                .headlineSmall!
                .color!
                .withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
