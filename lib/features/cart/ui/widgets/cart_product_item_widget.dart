import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sum_app/app/app_colors.dart';
import 'package:sum_app/features/cart/ui/controllers/delete_item_from_cart_controller.dart';
import 'package:sum_app/features/common/data/models/product_model.dart';
import 'package:sum_app/features/common/data/models/wishlist_or_cart_item_list_model.dart';
import 'package:sum_app/features/common/ui/widgets/product_quantity_inc_dec_button.dart';

class CartProductItemWidget extends StatelessWidget {
  const CartProductItemWidget({
    super.key,
    required this.productModel,
    required this.results,
  });

  final Product productModel;

  final Results results;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 1,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 14,
        ),
        child: Row(
          children: [
            productModel.photos?.isNotEmpty == true
                ? Image.network(
                    productModel.photos!.first,
                    width: 90,
                    height: 90,
                    fit: BoxFit.scaleDown,
                  )
                : Image.asset(
                    'assets/images/shoe.png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.scaleDown,
                  ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              productModel.title ?? '',
                              style: textTheme.bodyLarge?.copyWith(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                    "Color: ${productModel.colors?.isNotEmpty == true ? productModel.colors!.first : 'N/A'}"),
                                const SizedBox(width: 8),
                                Text(
                                    "Size: ${productModel.sizes?.isNotEmpty == true ? productModel.sizes!.first : 'N/A'}"),
                              ],
                            )
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.find<DeleteItemFromCartController>()
                              .deleteFromCartList(results.id ?? '');
                        },
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${productModel.currentPrice ?? ''}",
                        style: const TextStyle(
                          color: AppColors.themeColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ProductQuantityIncDecButton(
                        onChange: (int numberOfItem) {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
