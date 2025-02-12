import 'package:get/get.dart';
import 'package:sum_app/app/urls.dart';
import 'package:sum_app/features/home/data/models/bannar_list_model.dart';
import 'package:sum_app/features/home/data/models/bannar_model.dart';
import 'package:sum_app/services/network_caller/network_caller.dart';

class HomeBannarListController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  BannarListModel? _bannarListModel;

  List<BannarModel> get bannarList => _bannarListModel?.bannarList ?? [];

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getHomeBannarList() async {
    _inProgress = true;
    update();
    bool isSuccess = false;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.bannarListUrl,
    );
    if (response.isSuccess) {
      _bannarListModel = BannarListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
