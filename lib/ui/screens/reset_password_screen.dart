import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sum_app/data/models/network_response.dart';
import 'package:sum_app/data/service/network_caller.dart';
import 'package:sum_app/data/utils/urls.dart';
import 'package:sum_app/ui/controllers/auth_controller.dart';
import 'package:sum_app/ui/screens/sign_in_screen.dart';
import 'package:sum_app/ui/utils/app_colors.dart';
import 'package:sum_app/ui/widgets/screen_background.dart';
import 'package:sum_app/ui/widgets/snack_bar_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();

  bool _inProgress = false;

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

  Widget _buildResetPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            obscureText: true,
            controller: _passwordTEController,
            decoration: const InputDecoration(
              hintText: 'New password',
            ),
            validator: (String? value) {
              if (value!.isEmpty ?? true) {
                return "Please enter your password";
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            enabled: !_inProgress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _confirmPasswordTEController,
            decoration: const InputDecoration(
              hintText: 'Confirm password',
            ),
            validator: (String? value) {
              if (value!.isEmpty ?? true) {
                return "Please enter your password";
              }
              if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
              if (value != _passwordTEController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
            enabled: !_inProgress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _onTapForgotPaswordButton,
            child: const Icon(Icons.arrow_circle_right_outlined),
          ),
        ],
      ),
    );
  }

  // void _onTapNextButton() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const SignInScreen(),
  //     ),
  //   );
  // }

  void _onTapForgotPaswordButton() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _resetPassword();
  }

  void _onTapSignIn() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (_) => false);
  }

  Future<void> _resetPassword() async {
    _inProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      'email': AuthController.resetEmail,
      'password': _passwordTEController.text,
      'OTP': AuthController.otp,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.resetPasswordUrl, body: requestBody);

    _inProgress = false;
    setState(() {});

    if (response.isSuccess) {
      AuthController.clearUserData();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (predicate) => false);
      showSnackBarMessage(context, "Password changed successfully");
    } else {
      showSnackBarMessage(context, 'Error: ${response.errorMessage}', true);
    }
  }
}
