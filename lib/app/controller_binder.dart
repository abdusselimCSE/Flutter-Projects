import 'package:get/get.dart';
import 'package:sum_app/features/common/ui/screens/controllers/main_bottom_nav_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
  }
}
