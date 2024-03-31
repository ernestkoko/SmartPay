import 'package:flutter/material.dart';
import 'package:smartpay/app/util/extension.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 0.5,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.black.withOpacity(0.8),
              Colors.white.withOpacity(0.5),
            ], begin: Alignment.centerRight, end: Alignment.centerLeft)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'OR',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 26,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.6),
                ),
          ),
        ),
        Expanded(
          child: Container(
            height: 0.5,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.white.withOpacity(0.5),
              Colors.black.withOpacity(0.8),
            ], begin: Alignment.centerRight, end: Alignment.centerLeft)),
          ),
        ),
      ],
    );
  }
}
