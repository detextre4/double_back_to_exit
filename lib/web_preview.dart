import 'package:flutter/material.dart';

class DoubleBackToExitWidget extends StatelessWidget {
  const DoubleBackToExitWidget({
    super.key,
    required this.snackBarMessage,
    required this.child,
  });
  final String snackBarMessage;
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
