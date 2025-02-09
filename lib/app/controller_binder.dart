import 'package:get/get.dart';
import 'package:sum_app/features/auth/ui/controllers/email_verification_controller.dart';
import 'package:sum_app/features/common/ui/screens/controllers/main_bottom_nav_controller.dart';
import 'package:sum_app/services/network_caller/network_caller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
    Get.put(NetworkCaller());
    Get.put(EmailVerificationController());
  }
}
