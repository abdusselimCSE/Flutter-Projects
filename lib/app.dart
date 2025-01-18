import 'package:flutter/material.dart';
import 'package:sum_app/app/app_theme_data.dart';
import 'package:sum_app/features/auth/ui/screens/splash_screen.dart';

class CraftyBay extends StatelessWidget {
  const CraftyBay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      themeMode: ThemeMode.dark,
      routes: {
        '/': (context) => const SplashScreen(),
      },
    );
  }
}
