import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sum_app/ui/screens/sign_in_screen.dart';
import 'package:sum_app/ui/utils/app_colors.dart';
import 'package:sum_app/ui/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 82),
                Text(
                  "Set Password",
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  "Minimum length of password should be 8 characters with letters and number combination",
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildResetPasswordForm(),
                const SizedBox(height: 48),
                Center(
                  child: _haveAccountSection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordForm() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'New password',
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Confirm password',
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _onTapNextButton,
          child: const Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }

  Widget _haveAccountSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: "Have an account? ",
        children: [
          TextSpan(
            text: "Sign In",
            style: const TextStyle(
              color: AppColors.themeColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  void _onTapForgotPaswordButton() {
    //TODO: implement on tap forgot password
  }

  void _onTapSignIn() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (_) => false);
  }
}
