import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppClickText extends StatelessWidget {
  const AppClickText({
    super.key,
    this.text1 = '',
    this.clickText = '',
    this.onTap,
  });

  final String text1;
  final String clickText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text1,
          style: Theme.of(context).textTheme.headlineSmall,
          children: [
            TextSpan(
                text: clickText,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                recognizer: TapGestureRecognizer()..onTap = onTap),
          ]),
    );
  }
}
