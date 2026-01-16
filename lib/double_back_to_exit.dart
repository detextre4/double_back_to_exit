import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Enum to define the modes for double back action
enum DoubleBackMode {
  pop,
  doublePop;
}

class DoubleBackToExit extends StatefulWidget {
  const DoubleBackToExit({
    super.key,
    required this.snackBarMessage,
    required this.child,
    this.onWillPop,
    this.onDoubleBack,
    this.doubleBackDuration = const Duration(milliseconds: 1350),
    this.snackbarTextAlign = TextAlign.center,
    this.snackbarTextStyle,
    this.snackbarBackgroundColor = Colors.black54,
    this.snackbarBehavior,
    this.snackbarMargin,
    this.snackbarPadding,
    this.snackbarWidth,
    this.mode = DoubleBackMode.doublePop,
    this.canPop = false,
    this.allowExitOnIOS = false,
  });

  final Widget child;
  final String snackBarMessage;
  final VoidCallback? onWillPop;
  final VoidCallback? onDoubleBack;
  final Duration doubleBackDuration;
  final TextStyle? snackbarTextStyle;
  final TextAlign snackbarTextAlign;
  final Color snackbarBackgroundColor;
  final SnackBarBehavior? snackbarBehavior;
  final EdgeInsets? snackbarMargin;
  final EdgeInsetsGeometry? snackbarPadding;
  final double? snackbarWidth;
  final DoubleBackMode mode;
  final bool canPop;
  // This boolean flag is used to allow the app to exit on iOS.
  // Note: Exiting an app programmatically on iOS is generally discouraged by Apple,
  // and may result in the app being rejected from the App Store.
  final bool allowExitOnIOS;

  @override
  State<DoubleBackToExit> createState() => _DoubleBackToExitState();
}

class _DoubleBackToExitState extends State<DoubleBackToExit> {
  DateTime? currentBackPressTime;

  // Handler for single back press
  void handlerPop() {
    if (widget.onWillPop != null) widget.onWillPop!();
  }

  // Handler for double back press
  void handlerDoublePop() {
    final canPop = Navigator.canPop(context);

    // Prevent exit on iOS if not allowed
    if (io.Platform.isIOS && !canPop && !widget.allowExitOnIOS) return;

    DateTime now = DateTime.now();

    // Show snackbar if double back press duration is not met
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
      return;
    }

    // Call onDoubleBack callback if provided
    if (widget.onDoubleBack != null) return widget.onDoubleBack!();

    // Pop the current route if possible
    if (canPop) return Navigator.pop(context);

    // Exit the app on Android
    if (io.Platform.isAndroid) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      io.exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return widget.child;

    return PopScope(
      canPop: widget.canPop,
      onPopInvokedWithResult: (didPop, result) => switch (widget.mode) {
        DoubleBackMode.doublePop => handlerDoublePop(),
        DoubleBackMode.pop => handlerPop(),
      },
      child: widget.child,
    );
  }
}
