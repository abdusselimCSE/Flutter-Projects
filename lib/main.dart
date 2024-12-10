

import 'package:flutter/material.dart';
import 'package:sum_app/map_screen.dart';

void main() {
  runApp(const LocationTrackingApp());
}

class LocationTrackingApp extends StatelessWidget {
  const LocationTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapScreen(),
    );
  }
}