import 'package:flutter/material.dart';

extension Spacer on num {
  Widget get verticalSpace => SizedBox(height: toDouble());

  Widget get horizontalSpace => SizedBox(width: toDouble());
}

extension LoopString on String {
  List<int> getIntArray() {
    final List<int> l = [];
    for (final rune in runes) {
      final char = String.fromCharCode(rune);
      final t = int.tryParse(char);
      if (t != null) {
        l.insert(l.length, t);
      }
    }
    return l;
  }

  bool get hasLowerUpperAndNumberCases =>
      RegExp(r'[A-Z]').hasMatch(this) &&
      RegExp(r'[a-z]').hasMatch(this) &&
      RegExp(r'[0-9]').hasMatch(this);
}

extension AppList on List {
  String getStringOfValues() {
    String k = '';
    for (final v in this) {
      k = '$k$v';
    }
    return k;
  }
}
