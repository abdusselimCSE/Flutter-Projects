import 'package:get/get.dart';
import 'package:sum_app/app/urls.dart';
import 'package:sum_app/features/auth/data/models/profile_model.dart';
import 'package:sum_app/services/network_caller/network_caller.dart';

class ReadProfileController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  ProfileModel? _profileModel;

  ProfileModel? get profileModel => _profileModel;

  Future<bool> readProfile(String token) async {
    _inProgress = true;
    update();
    bool isSuccess = false;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.readProfile,
      accessToken: token,
    );

    if (response.isSuccess) {
      _errorMessage = null;
      if (response.responseData['data'] != null) {
        _profileModel = ProfileModel.fromJson(response.responseData['data']);
      } else {
        _profileModel = null;
      }
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
