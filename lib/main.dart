import 'package:flutter/material.dart';
import 'package:kalkulatorzakat/features/calculator_page.dart';
import 'package:kalkulatorzakat/utils/constants.dart' as Constants;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
      theme: ThemeData(
        primarySwatch: Constants.PRIMARY_COLOR,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculatorPage(title: Constants.APP_NAME),
    );
  }
}
