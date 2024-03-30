import 'package:flutter/material.dart';
import 'package:smartpay/app/util/extension.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(),
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
          child: Divider(),
        ),
      ],
    );
  }
}
