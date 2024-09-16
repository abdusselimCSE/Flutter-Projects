import 'package:flutter/material.dart';
import 'package:sum_app/home_screen.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppHomeScreen(),
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }
}
