import 'package:get/get.dart';
import 'package:sum_app/app/urls.dart';
import 'package:sum_app/features/common/data/models/product_list_model.dart';
import 'package:sum_app/features/common/data/models/product_model.dart';
import 'package:sum_app/services/network_caller/network_caller.dart';

class ProductListController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  ProductListModel? _productListModel;

  List<ProductModel> get productList => _productListModel?.productList ?? [];

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getProductListByCategory(int categoryId) async {
    bool isSuccess = false;

    _inProgress = true;

    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.productListByCategoryUrl(categoryId),
    );
    if (response.isSuccess) {
      _productListModel = ProductListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;

    update();
    return isSuccess;
  }
}
