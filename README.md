# double_back_to_exit

[![Pub](https://img.shields.io/pub/v/double_back_to_exit.svg)](https://pub.dev/packages/double_back_to_exit)

A Flutter package that provides a widget to implement the double back press to exit functionality in your app.

## Features

- Implements the double back press to exit functionality.
- Works on both Android and iOS.
- Customizable snackbar message.
- Customizable duration between back presses.
- Allows conditional exit on iOS.

## Getting started

In your Flutter project, add the `double_back_to_exit` dependency to your `pubspec.yaml` file:

```yaml
dependencies: 
  double_back_to_exit: ^1.2.0
```

## Usage

Import the package in your Dart file:

`import 'package:double_back_to_exit/double_back_to_exit.dart';`

Wrap your main widget with the `DoubleBackToExitWidget`:

```dart
DoubleBackToExitWidget(
  snackBarMessage: 'Press back again to exit', 
  child: MaterialApp( 
    // Your app content here 
  ), 
)
```

### Android Configuration

To ensure the double back press functionality works correctly on Android, add the following line to the <application> tag in your AndroidManifest.xml file:

```xml
<application
    android:enableOnBackInvokedCallback="true"
    ... >
    <!-- Other configurations -->
</application>
```

## Example

For a complete example, see the [example](https://github.com/example/example) folder.

## Additional information

For more information, check out the [documentation](https://pub.dev/documentation/double_back_to_exit/latest/double_back_to_exit/double_back_to_exit-library.html).

If you find any issues or would like to contribute, please visit the [GitHub repository](https://github.com/example/example).

## License

This package is licensed under the [MIT License](https://opensource.org/licenses/MIT).