import 'package:get/get.dart';
import 'package:sum_app/features/auth/ui/controllers/otp_verification_controller.dart';
import 'package:sum_app/features/auth/ui/controllers/sign_in_controller.dart';
import 'package:sum_app/features/auth/ui/controllers/sign_up_controller.dart';
import 'package:sum_app/features/cart/ui/controllers/add_to_cart_controller.dart';
import 'package:sum_app/features/cart/ui/controllers/cart_item_list_controller.dart';
import 'package:sum_app/features/common/ui/controllers/auth_controller.dart';
import 'package:sum_app/features/common/ui/controllers/category_list_controller.dart';
import 'package:sum_app/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:sum_app/features/common/ui/controllers/product_list_by_category_controller.dart';
import 'package:sum_app/features/home/ui/controllers/popular_product_listcontroller.dart';
import 'package:sum_app/features/home/ui/controllers/slider_list_controller.dart';
import 'package:sum_app/features/product/ui/controllers/product_details_controller.dart';
import 'package:sum_app/features/wishlist/ui/controllers/add_to_wishlist_controller.dart';
import 'package:sum_app/features/wishlist/ui/controllers/wishlist_item_list_controller.dart';
import 'package:sum_app/services/network_caller/network_caller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
    Get.put(NetworkCaller());
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(OtpVerificationController());
    Get.put(SliderListController());
    Get.put(AuthController());
    Get.put(CategoryListController());
    Get.put(PopularProductListController());
    Get.put(ProductListByCategoryController());
    Get.put(ProductDetailsController());
    Get.put(WishListProductItemController());
    Get.put(AddToWishlistController());
    Get.put(CartProductItemController());
    Get.put(AddToCartListController());
  }
}
