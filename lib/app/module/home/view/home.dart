import 'package:flutter/material.dart';
import 'package:smartpay/app/asset/image.dart';
import 'package:smartpay/app/util/extension.dart';
import 'package:smartpay/app/widgets/button.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.token});

  final String token;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int click = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAsset.congrats),
                  20.verticalSpace,
                  Text(
                    'Your beautiful token is here boss:',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  30.verticalSpace,
                  Text(
                    widget.token,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                        ),
                  ),
                  30.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      click++;
                      setState(() {});
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
                  if (click >= 3)
                    AppButton1(
                      active: true,
                      title: "Back to login",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
