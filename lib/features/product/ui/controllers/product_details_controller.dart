import 'package:get/get.dart';
import 'package:sum_app/app/urls.dart';
import 'package:sum_app/features/common/data/models/product_model.dart';
import 'package:sum_app/features/product/data/models/product_details_model.dart';
import 'package:sum_app/services/network_caller/network_caller.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  Product? _productDetails;

  Product? get productDetails => _productDetails;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getProductDetails(String productId) async {
    _inProgress = true;
    update();
    bool isSuccess = false;

    print("This is product id : $productId");

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.productDetailsUrl(productId),
    );

    if (response.isSuccess) {
      print("Raw API Response: ${response.responseData}");

      ProductDetailsModel parsedResponse =
          ProductDetailsModel.fromJson(response.responseData);

      _productDetails = parsedResponse.data;

      print("Final Parsed Product ID: ${_productDetails?.id}");

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      print("API Error: $_errorMessage");
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
