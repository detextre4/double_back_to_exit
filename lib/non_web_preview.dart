import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DoubleBackToExitWidget extends StatefulWidget {
  const DoubleBackToExitWidget({
    super.key,
    required this.snackBarMessage,
    required this.child,
    this.onDoubleBack,
    this.doubleBackDuration = const Duration(milliseconds: 1350),
    this.textAlign = TextAlign.center,
    this.textStyle,
    this.backgroundColor = Colors.black54,
    this.behavior,
    this.margin,
    this.padding,
    this.width,
  });
  final Widget child;
  final String snackBarMessage;
  final FutureOr<bool> Function()? onDoubleBack;
  final Duration doubleBackDuration;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final Color backgroundColor;
  final SnackBarBehavior? behavior;
  final EdgeInsets? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;

  @override
  State<DoubleBackToExitWidget> createState() =>
      _DoubleBackToCloseMobileState();
}

class _DoubleBackToCloseMobileState extends State<DoubleBackToExitWidget> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    // * Web
    if (kIsWeb) return widget.child;

    Future<bool> onWillPop() async {
      DateTime now = DateTime.now();

      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > widget.doubleBackDuration) {
        currentBackPressTime = now;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            widget.snackBarMessage,
            textAlign: widget.textAlign,
            style: widget.textStyle ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
          ),
          duration: widget.doubleBackDuration,
          backgroundColor: widget.backgroundColor,
          behavior: widget.behavior,
          margin: widget.margin,
          padding: widget.padding,
          width: widget.width,
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
