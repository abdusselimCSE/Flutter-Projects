import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sum_app/app/app_colors.dart';
import 'package:sum_app/app/app_constants/app_constants.dart';
import 'package:sum_app/features/auth/ui/controllers/otp_verification_controller.dart';
import 'package:sum_app/features/auth/ui/controllers/read_profile_controller.dart';
import 'package:sum_app/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:sum_app/features/common/ui/screens/main_bottom_nav_screen.dart';

import 'complete_profile_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});

  static const String name = '/otp-verification';

  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RxInt _remainingTime = AppContants.resendOtpTimeOutInSecs.obs;
  late Timer timer;
  final RxBool _enableResendCodeButton = false.obs;
  final OtpVerificationController _otpVerificationController =
      Get.find<OtpVerificationController>();

  @override
  void initState() {
    super.initState();
    _startResendCodeTimer();
  }

  void _startResendCodeTimer() {
    _enableResendCodeButton.value = false;
    _remainingTime.value = AppContants.resendOtpTimeOutInSecs;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) {
        // print(t.tick);
        _remainingTime.value--;
        if (_remainingTime.value == 0) {
          t.cancel();
          _enableResendCodeButton.value = true;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 80),
                const AppLogoWidget(),
                const SizedBox(height: 24),
                Text(
                  "Enter OTP Code",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "A 4 digit otp has been sent to your email",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 24),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(milliseconds: 300),
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      activeFillColor: AppColors.themeColor,
                      inactiveColor: AppColors.themeColor,
                      borderRadius: BorderRadius.circular(8)),
                  keyboardType: TextInputType.number,
                  appContext: context,
                  controller: _otpTEController,
                  validator: (String? value) {
                    if (value?.length != 6) {
                      return "Enter OTP code";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                GetBuilder<OtpVerificationController>(builder: (controller) {
                  if (controller.inProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: _onTapNextButton,
                    child: const Text("Next"),
                  );
                }),
                const SizedBox(height: 24),

                //TODO: enable button when 120s is done and invisible the text
                //stream, timer(setState), getx(obs)
                Obx(
                  () => Visibility(
                    visible: !_enableResendCodeButton.value,
                    child: RichText(
                      text: TextSpan(
                        text: "This code will expire in ",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                            text: '${_remainingTime}',
                            style: const TextStyle(
                              color: AppColors.themeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: _enableResendCodeButton.value,
                    child: TextButton(
                      onPressed: () {
                        _startResendCodeTimer();
                      },
                      child: const Text("Resend Code"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapNextButton() async {
    if (_formKey.currentState!.validate()) {
      final bool response = await _otpVerificationController.verifyOtp(
          widget.email, _otpTEController.text);
      if (response) {
        if (_otpVerificationController.shouldNavigateToCompleteProfile) {
          if (mounted) {
            Navigator.pushNamed(context, CompleteProfileScreen.name);
          }
        }
      } else {
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainBottomNavScreen.name, (_) => false);
        }
      }
    }

    @override
    void dispose() {
      timer.cancel();
      super.dispose();
    }
  }
}
