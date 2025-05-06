import 'dart:async';
import 'package:Kdru_Guide_app/screens/firstHomePage.dart'
    show HomeFirstPage, HomePage;
import 'package:Kdru_Guide_app/widgets/custom_header.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(UniversityFutureApp());
}

class UniversityFutureApp extends StatelessWidget {
  const UniversityFutureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'کند هار پوهنتون',
      theme: ThemeData.light(),
      home: HomeFirstPage(), // Set HomePage as the home widget
    );
  }
}
