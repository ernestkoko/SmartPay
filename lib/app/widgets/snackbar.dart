import 'package:flutter/material.dart';
import 'package:smartpay/app/constants.dart';

enum SnackBarMessageType {
  success,
  error,
  warning,
}

void showAppSnackBar({
  required String message,
  Color? color,
  SnackBarMessageType messageType = SnackBarMessageType.success,
}) {
  scaffoldKey.currentState!
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.up,
        margin: EdgeInsets.only(
            bottom:
                MediaQuery.of(scaffoldKey.currentContext!).size.height - 150,
            left: 30,
            right: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(150)),
        padding: EdgeInsets.zero,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  message,
                  style: Theme.of(scaffoldKey.currentContext!)
                      .textTheme
                      .bodyMedium,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: messageType == SnackBarMessageType.success
                      ? Colors.green
                      : Colors.red,
                  shape: BoxShape.circle),
              child: const Icon(Icons.verified_rounded),
            )
          ],
        ),
      ),
    );
}
