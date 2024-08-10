library double_back_to_exit;

import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DoubleBackToExit extends StatefulWidget {
  const DoubleBackToExit({
    super.key,
    required this.snackBarMessage,
    required this.child,
    this.onDoubleBack,
    this.doubleBackDuration = const Duration(milliseconds: 1350),
    this.snackbarTextAlign = TextAlign.center,
    this.snackbarTextStyle,
    this.snackbarBackgroundColor = Colors.black54,
    this.snackbarBehavior,
    this.snackbarMargin,
    this.snackbarPadding,
    this.snackbarWidth,
    this.enabled = true,
  });
  final Widget child;
  final String snackBarMessage;
  final FutureOr<bool> Function()? onDoubleBack;
  final Duration doubleBackDuration;
  final TextStyle? snackbarTextStyle;
  final TextAlign snackbarTextAlign;
  final Color snackbarBackgroundColor;
  final SnackBarBehavior? snackbarBehavior;
  final EdgeInsets? snackbarMargin;
  final EdgeInsetsGeometry? snackbarPadding;
  final double? snackbarWidth;
  final bool enabled;

  @override
  State<DoubleBackToExit> createState() => _DoubleBackToExitState();
}

class _DoubleBackToExitState extends State<DoubleBackToExit> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    // * Web
    if (kIsWeb || !widget.enabled) return widget.child;

    Future<bool> onWillPop() async {
      DateTime now = DateTime.now();

      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > widget.doubleBackDuration) {
        currentBackPressTime = now;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            widget.snackBarMessage,
            textAlign: widget.snackbarTextAlign,
            style: widget.snackbarTextStyle ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
          ),
          duration: widget.doubleBackDuration,
          backgroundColor: widget.snackbarBackgroundColor,
          behavior: widget.snackbarBehavior,
          margin: widget.snackbarMargin,
          padding: widget.snackbarPadding,
          width: widget.snackbarWidth,
        ));
        return false;
      }

      if (widget.onDoubleBack != null) return await widget.onDoubleBack!();

      return true;
    }

    // * Android
    if (Platform.isAndroid) {
      return WillPopScope(
        onWillPop: onWillPop,
        child: widget.child,
      );
    }

    // * IOS
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) async {
          if (details.delta.dx > 8) await onWillPop();
        },
        child: widget.child,
      ),
    );
  }
}
