import 'package:get/get.dart';
import 'package:sum_app/app/urls.dart';
import 'package:sum_app/features/common/ui/controllers/auth_controller.dart';
import 'package:sum_app/services/network_caller/network_caller.dart';

class AddToCartListController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> addToCartList(String productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final authController = Get.find<AuthController>();

    if (authController.accessToken == null) {
      _inProgress = false;
      update();
      return false;
    }

    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(
      Urls.addItemToCartUrl,
      accessToken: authController.accessToken,
      body: {"product": productId},
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
