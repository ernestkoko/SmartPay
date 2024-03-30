import 'package:flutter/material.dart';
import 'package:smartpay/app/util/extension.dart';

class AppButton1 extends StatelessWidget {
  const AppButton1({
    super.key,
    required this.title,
    this.active = false,
    this.loading = false,
    this.onPressed,
  });

  final String title;
  final bool active;
  final bool loading;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: active && loading
          ? () {}
          : active
              ? () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (onPressed != null) {
                    onPressed!();
                  }
                }
              : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        disabledBackgroundColor: Colors.grey,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: !loading
          ? Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: const Color(0xFFFFFFFF),
                  ),
            )
          : const CircularProgressIndicator(),
    );
  }
}

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.of(context).pop();
          },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 0.5)),
        child: const Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.black,
          size: 20,
        ),
      ),
    );
  }
}

///Third party sign-in
class ThirdPartySignInButtons extends StatelessWidget {
  const ThirdPartySignInButtons({
    super.key,
    this.onTap1,
    this.onTap2,
    this.loading = false,
  });

  final Function()? onTap1;
  final Function()? onTap2;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _button(onTap: onTap1, loading: loading),
        ),
        20.horizontalSpace,
        Expanded(
          child: _button(onTap: onTap2, loading: loading),
        ),
      ],
    );
  }

  Widget _button({
    Function()? onTap,
    bool loading = false,
  }) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: Colors.grey)),
        child: const Icon(Icons.apple),
      ),
    );
  }
}
