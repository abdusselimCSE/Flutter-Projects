import 'package:get/get.dart';
import 'package:sum_app/app/urls.dart';
import 'package:sum_app/features/common/data/models/product_model.dart';
import 'package:sum_app/features/common/data/models/wishlist_or_cart_item_list_model.dart';
import 'package:sum_app/features/common/ui/controllers/auth_controller.dart';
import 'package:sum_app/services/network_caller/network_caller.dart';

class WishListProductItemController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  WishlistOrCartItemListModel? _wishlistOrCartItemListModel;

  List<Product> get wishlistProducts =>
      _wishlistOrCartItemListModel?.data?.results
          ?.map((result) => result.product!)
          .where((product) => product != null)
          .toList() ??
      [];

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getWishlistItemList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final authController = Get.find<AuthController>();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.wishListItemUrl,
      accessToken: authController.accessToken,
    );

    // print("✅ API Response: ${response.responseData}"); // Debugging

    if (response.isSuccess) {
      wishlistProducts.clear();
      _wishlistOrCartItemListModel =
          WishlistOrCartItemListModel.fromJson(response.responseData);
      isSuccess = true;

      // Print to confirm correct data is received
      // print(
      //     "✅ Parsed Products: ${_wishlistOrCartItemListModel?.data?.results?.map((e) => e.product?.title).toList()}");
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
