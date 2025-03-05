import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sum_app/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:sum_app/features/common/ui/widgets/product_item_widget.dart';
import 'package:sum_app/features/wishlist/ui/controllers/wishlist_item_list_controller.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  static const String name = '/wishlist-screen';

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<WishListProductItemController>().getWishlistItemList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _onPop(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("WishList"),
          leading: IconButton(
            onPressed: _onPop,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: GetBuilder<WishListProductItemController>(builder: (controller) {
          if (controller.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.wishlistProducts.isEmpty) {
            return const Center(child: Text("No items in wishlist"));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                crossAxisSpacing: 2,
                mainAxisSpacing: 8,
              ),
              itemCount: controller.wishlistProducts.length,
              itemBuilder: (context, index) {
                return ProductItemWidget(
                  productModel: controller.wishlistProducts[index],
                );
              },
            ),
          );
        }),
      ),
    );
  }

  void _onPop() {
    Get.find<MainBottomNavController>().backToHome();
  }
}
