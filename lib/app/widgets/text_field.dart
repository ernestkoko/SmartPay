import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smartpay/app/util/extension.dart';

enum TextType { country, password }

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.hintText,
    this.errorText,
    this.password = false,
    this.onChanged,
    this.enabled = true,
    this.controller,
    this.keyboardType,
    this.textType,
  });

  final String? hintText;
  final String? errorText;
  final bool password;
  final bool enabled;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextType? textType;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _togglePassword = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (v) {
        if (widget.textType != null) {
          //If password ensure it has upper, lower cases and number
          if (widget.textType == TextType.password) {
            widget.controller?.text = v;
            if (!v.hasLowerUpperAndNumberCases) {
              _errorMessage =
                  'Password should contain one lower, upper and number cases';
              setState(() {});
              return;
            } else if (v.length < 7) {
              _errorMessage = "Password should be at least 7 characters";
              setState(() {});
              return;
            } else {
              _errorMessage = null;
            }
          } else if (widget.textType == TextType.country) {
            widget.controller?.text = v;
            if (v.length != 2) {
              _errorMessage = "Country should be max 2 characters e.g NG";
              setState(() {});
              return;
            } else {
              _errorMessage = null;
            }
          }
        }

        if (widget.onChanged != null) {
          widget.onChanged!(v);
        }
        setState(() {});
      },
      controller: widget.controller,
      obscureText: widget.password ? !_togglePassword : false,
      keyboardType: widget.keyboardType,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            decoration: TextDecoration.none,
          ),
      decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          enabled: widget.enabled,
          errorText: _errorMessage ?? widget.errorText,
          fillColor: Colors.grey.withOpacity(0.1),
          hintStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: const Color(0xFF9CA3AF),
              ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Color(0xFF2FA2B9),
              ),
              borderRadius: BorderRadius.circular(16)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              style: BorderStyle.solid,
              color: Colors.red.withOpacity(0.8),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              style: BorderStyle.solid,
              color: Colors.red.withOpacity(0.8),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          suffixIcon: widget.password
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _togglePassword = !_togglePassword;
                    });
                  },
                  icon: Icon(
                    _togglePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                )
              : null),
    );
  }
}
