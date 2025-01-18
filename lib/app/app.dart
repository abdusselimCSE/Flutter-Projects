import 'package:flutter/material.dart';
import 'package:sum_app/app/app_theme_data.dart';
import 'package:sum_app/features/auth/ui/screens/email_verification_screen.dart';
import 'package:sum_app/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:sum_app/features/auth/ui/screens/splash_screen.dart';

class CraftyBay extends StatelessWidget {
  const CraftyBay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      themeMode: ThemeMode.light,
      routes: {
        '/': (context) => const SplashScreen(),
        EmailVerificationScreen.name: (context) => EmailVerificationScreen(),
        OtpVerificationScreen.name: (context) => OtpVerificationScreen(),
      },
    );
  }
}
