import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sum_app/app/app_colors.dart';
import 'package:sum_app/features/cart/ui/controllers/cart_item_list_controller.dart';
import 'package:sum_app/features/cart/ui/widgets/cart_product_item_widget.dart';
import 'package:sum_app/features/common/data/models/wishlist_or_cart_item_list_model.dart';
import 'package:sum_app/features/common/ui/controllers/main_bottom_nav_controller.dart';

class CartListScreen extends StatefulWidget {
  final Results? results;

  const CartListScreen({super.key, this.results});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CartProductItemController>().getCartItemList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _onPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Cart"),
          leading: IconButton(
              onPressed: _onPop, icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: GetBuilder<CartProductItemController>(builder: (controller) {
          if (controller.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.cartProducts.isEmpty) {
            return const Center(child: Text("No items in Cart"));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.cartProducts.length,
                  itemBuilder: (context, index) {
                    return CartProductItemWidget(
                      productModel: controller.cartProducts[index],
                      results: controller.cartItems[index],
                    );
                  },
                ),
              ),
              _buildPriceAndCheckoutSection(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildPriceAndCheckoutSection() {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "Total Price",
                style: textTheme.titleSmall,
              ),
              const Text(
                "\$100",
                style: TextStyle(
                  color: AppColors.themeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Checkout"),
            ),
          ),
        ],
      ),
    );
  }

  void _onPop() {
    Get.find<MainBottomNavController>().backToHome();
  }
}
