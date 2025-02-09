import 'package:get/get.dart';
import 'package:sum_app/app/urls.dart';
import 'package:sum_app/features/auth/ui/controllers/read_profile_controller.dart';
import 'package:sum_app/features/common/ui/controllers/auth_controller.dart';
import 'package:sum_app/services/network_caller/network_caller.dart';

class OtpVerificationController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool _shouldNavigateToCompleteProfile = false;

  bool get shouldNavigateToCompleteProfile => _shouldNavigateToCompleteProfile;

  String? _token;

  String? get token => _token;

  Future<bool> verifyOtp(String email, String otp) async {
    _inProgress = true;
    update();
    bool isSuccess = false;

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.verifyOtpUrl(email, otp));

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      String token = response.responseData['data'];
      await Get.find<ReadProfileController>().readProfile(token);
      if (Get.find<ReadProfileController>().profileModel != null) {
        //save access token and profile data
        AuthController authController = Get.find<AuthController>();
        await authController.saveUserData(
            token, Get.find<ReadProfileController>().profileModel!);
        _shouldNavigateToCompleteProfile = false;
      } else {
        _shouldNavigateToCompleteProfile = true;
        //TODO: Complete profile
      }
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
