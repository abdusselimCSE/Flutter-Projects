import 'package:get/get.dart';
import 'package:sum_app/app/urls.dart';
import 'package:sum_app/features/common/data/models/category/product_by_category_model.dart';
import 'package:sum_app/features/common/data/models/product_model.dart';
import 'package:sum_app/services/network_caller/network_caller.dart';

class ProductListByCategoryController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  ProductListByCategoryModel? _productListByCategoryModel;

  List<Product> get productList =>
      _productListByCategoryModel?.data?.results ?? [];

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getProductListByCategory(String categoryId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.productListByCategoryUrl(categoryId),
    );

    if (response.isSuccess) {
      _productListByCategoryModel =
          ProductListByCategoryModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
