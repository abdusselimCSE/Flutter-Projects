import 'package:get/get.dart';
import 'package:sum_app/app/urls.dart';
import 'package:sum_app/features/common/data/models/category_list_model.dart';
import 'package:sum_app/features/common/data/models/category_model.dart';
import 'package:sum_app/services/network_caller/network_caller.dart';

class CategoryListController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  CategoryListModel? _categoryListModel;

  List<CategoryModel> get categoryList =>
      _categoryListModel?.categoryList ?? [];

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getCategoryList() async {
    _inProgress = true;
    update();
    bool isSuccess = false;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.categoryListUrl,
    );
    if (response.isSuccess) {
      _categoryListModel = CategoryListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
