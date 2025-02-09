import 'package:get/get.dart';
import 'package:sum_app/features/auth/ui/controllers/email_verification_controller.dart';
import 'package:sum_app/features/auth/ui/controllers/otp_verification_controller.dart';
import 'package:sum_app/features/auth/ui/controllers/read_profile_controller.dart';
import 'package:sum_app/features/common/ui/controllers/auth_controller.dart';
import 'package:sum_app/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:sum_app/services/network_caller/network_caller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
    Get.put(NetworkCaller());
    Get.put(EmailVerificationController());
    Get.put(OtpVerificationController());
    Get.put(ReadProfileController());
    Get.put(AuthController());
  }
}
