import 'package:flutter/material.dart';
import 'package:foodcount/colors.dart';
import 'package:foodcount/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calorie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.bgColor,
      ),
      home: const HomePage(),
    );
  }
}
