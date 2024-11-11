import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sum_app/data/models/network_response.dart';
import 'package:sum_app/data/service/network_caller.dart';
import 'package:sum_app/data/utils/urls.dart';
import 'package:sum_app/ui/controllers/auth_controller.dart';
import 'package:sum_app/ui/screens/forgot_password_otp_screen.dart';
import 'package:sum_app/ui/utils/app_colors.dart';
import 'package:sum_app/ui/widgets/screen_background.dart';
import 'package:sum_app/ui/widgets/snack_bar_message.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
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
                  "Your Email Address",
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  "A 6 digit verification pin will send to your email address ",
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildVerifyEmailForm(),
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

  Widget _buildVerifyEmailForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _onTapNextButton,
            child: const Icon(Icons.arrow_circle_right_outlined),
          ),
        ],
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

  void _onTapNextButton() {
    _sendOtp();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordOtpScreen(),
      ),
    );
  }

  // void _onTapForgotPaswordButton() {
  //   //TODO: implement on tap forgot password
  // }

  void _onTapSignIn() {
    Navigator.pop(context);
  }

  Future<void> _sendOtp() async {
    _inProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.checkUserEmailExistUrl(email: _emailTEController.text.trim()),
    );

    print(_emailTEController.text);

    _inProgress = false;
    setState(() {});

    if (response.isSuccess) {
      AuthController.saveResetEmail(_emailTEController.text.trim());

      showSnackBarMessage(context, 'OTP sent to your email address');
    } else {
      showSnackBarMessage(context, 'Error: ${response.errorMessage}', true);
    }
  }
}
