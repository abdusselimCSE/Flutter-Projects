import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sum_app/features/common/ui/controllers/product_list_by_category_controller.dart';
import 'package:sum_app/features/common/ui/widgets/product_item_widget.dart';

class ProductListByCategoryScreen extends StatefulWidget {
  static const String name = '/product-list-by-category';

  const ProductListByCategoryScreen({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  final String categoryName;
  final String categoryId;

  @override
  State<ProductListByCategoryScreen> createState() =>
      _ProductListByCategoryScreenState();
}

class _ProductListByCategoryScreenState
    extends State<ProductListByCategoryScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductListByCategoryController>()
        .getProductListByCategory(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.categoryName),
      ),
      body: GetBuilder<ProductListByCategoryController>(builder: (controller) {
        if (controller.inProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.productList.isEmpty) {
          return const Center(
            child: Text(
              "No products found",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          );
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 2,
            mainAxisSpacing: 8,
          ),
          itemCount: controller.productList.length,
          itemBuilder: (context, index) {
            final product = controller.productList[index];
            return ProductItemWidget(productModel: product);
          },
        );
      }),
    );
  }
}
