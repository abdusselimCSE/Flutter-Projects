import 'package:get/get.dart';
import 'package:sum_app/app/urls.dart';
import 'package:sum_app/features/common/data/models/product_model.dart';
import 'package:sum_app/features/common/data/models/wishlist_or_cart_item_list_model.dart';
import 'package:sum_app/features/common/ui/controllers/auth_controller.dart';
import 'package:sum_app/services/network_caller/network_caller.dart';

class CartProductItemController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  WishlistOrCartItemListModel? _cartItemListModel;

  WishlistOrCartItemListModel? get cartItemListModel => _cartItemListModel;

  List<Results> get cartItems => _cartItemListModel?.data?.results ?? [];

  List<Product> get cartProducts => cartItems.map((e) => e.product!).toList();

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getCartItemList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final authController = Get.find<AuthController>();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.cartListItemUrl,
      accessToken: authController.accessToken,
    );

    if (response.isSuccess) {
      _cartItemListModel =
          WishlistOrCartItemListModel.fromJson(response.responseData);
      isSuccess = true;
      //
      // /// Debugging: Print all cart item IDs and product names
      // print("✅ Total items in cart: ${cartItems.length}");
      // for (var item in cartItems) {
      //   print("🛒 Cart Item ID: ${item.id}, Product: ${item.product?.title}");
      // }
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
