import 'package:flutter/material.dart';
import 'package:neumorphic_design_app/home_page.dart';
import 'package:neumorphic_design_app/home_page_2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
