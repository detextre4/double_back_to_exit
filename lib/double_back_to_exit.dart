library double_back_to_exit;

import 'dart:async';
import 'package:flutter/material.dart';
import 'non_web_preview.dart' if (dart.library.html) 'web_preview.dart';

class DoubleBackToExit extends StatelessWidget {
  const DoubleBackToExit({
    super.key,
    required this.snackBarMessage,
    required this.child,
    this.onDoubleBack,
    this.doubleBackDuration = const Duration(milliseconds: 1350),
  });
  final Widget child;
  final String snackBarMessage;
  final FutureOr<bool> Function()? onDoubleBack;
  final Duration doubleBackDuration;

  @override
  Widget build(BuildContext context) {
    return DoubleBackToExitWidget(
        snackBarMessage: snackBarMessage, child: child);
  }
}
