import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:double_back_to_exit/double_back_to_exit.dart';

void main() {
  testWidgets('DoubleBackToExitWidget shows snackbar on first back press',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: DoubleBackToExitWidget(
          snackBarMessage: 'Press back again to exit',
          child: Container(),
        ),
      ),
    );

    // Perform the first back press
    await tester.pageBack();

    // Verify that the snackbar is shown
    expect(find.text('Press back again to exit'), findsOneWidget);
  });

  testWidgets('DoubleBackToExitWidget calls onDoubleBack on second back press',
      (WidgetTester tester) async {
    bool onDoubleBackCalled = false;

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: DoubleBackToExitWidget(
          snackBarMessage: 'Press back again to exit',
          onDoubleBack: () {
            onDoubleBackCalled = true;
            return Future.value(true);
          },
          child: Container(),
        ),
      ),
    );

    // Perform the first back press
    await tester.pageBack();

    // Perform the second back press
    await tester.pageBack();

    // Verify that onDoubleBack is called
    expect(onDoubleBackCalled, isTrue);
  });
}
