import 'package:flutter/material.dart';
import 'package:ose_settings_application/Views/SettingsNavigation.dart';

void main() => runApp(MyApp());
PageStorageKey previousInput = new PageStorageKey("Previous values");

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter OSE settings';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home : SettingsNavigation()
    );
  }
}









