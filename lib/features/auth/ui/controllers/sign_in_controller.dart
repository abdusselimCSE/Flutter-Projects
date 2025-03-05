import 'package:get/get.dart';
import 'package:sum_app/app/urls.dart';
import 'package:sum_app/features/auth/data/models/auth_success_model.dart';
import 'package:sum_app/features/common/ui/controllers/auth_controller.dart';
import 'package:sum_app/services/network_caller/network_caller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    _inProgress = true;
    update();
    bool isSuccess = false;

    final requestParams = {
      "email": email,
      "password": password,
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.signInUrl, body: requestParams);

    if (response.isSuccess) {
      AuthSuccessModel signInModel =
          AuthSuccessModel.fromJson(response.responseData);
      AuthController authController = Get.find<AuthController>();
      await authController.saveUserData(
          signInModel.data!.token!, signInModel.data!.user!);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
