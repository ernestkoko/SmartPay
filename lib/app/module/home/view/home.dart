import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartpay/app/animations/slide.dart';
import 'package:smartpay/app/asset/image.dart';
import 'package:smartpay/app/module/home/bloc/home_bloc.dart';
import 'package:smartpay/app/route/app_route.dart';
import 'package:smartpay/app/util/extension.dart';
import 'package:smartpay/app/widgets/button.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.token});

  final String token;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            final bloc = context.read<HomeBloc>();
            if (state is HomeLoadingState && state.loading) {
              return Center(child: CircularProgressIndicator());
            }
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAsset.congrats),
                    20.verticalSpace,
                    Text(
                      'Your beautiful secret is here boss:',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    30.verticalSpace,
                    Text(
                      context.read<HomeBloc>().secret,
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                              ),
                    ),
                    30.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        bloc.add(OnInitHomeEvent());
                      },
                      child: Text(
                        'Don\'t even try using the back button because I disabled it. LOL. But if you click me 3 times I will help you!',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.lightGreen.withOpacity(0.3),
                                  fontSize: 14,
                                ),
                      ),
                    ),
                    20.verticalSpace,
                    if (bloc.click >= 3)
                      AppSlideAnimation(
                        beginOffset: Offset(0.0, bloc.click == 3 ? 20.0 : 0.0),
                        child: AppButton1(
                          active: true,
                          title: "Back to login",
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoute.loginPage);
                          },
                        ),
                      )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
