import 'package:get/get.dart';
import 'package:sum_app/app/urls.dart';
import 'package:sum_app/services/network_caller/network_caller.dart';

class EmailVerificationController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> verifyEmail(String email) async {
    _inProgress = true;
    update();
    bool isSuccess = false;

    final NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(Urls.verifyEmailUrl(email));

    if (response.isSuccess) {
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
