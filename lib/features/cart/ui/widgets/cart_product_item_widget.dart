import 'package:flutter/material.dart';
import 'package:sum_app/app/app_colors.dart';
import 'package:sum_app/app/assets_path.dart';
import 'package:sum_app/features/common/ui/widgets/product_quantity_inc_dec_button.dart';

class CartProductItemWidget extends StatelessWidget {
  const CartProductItemWidget({
    super.key,
  });

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
            Image.asset(
              AssetsPath.dummyImagePng,
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
                          children: [
                            Text(
                              maxLines: 1,
                              "Nike Shoe - AK4539 New Year Deal",
                              style: textTheme.bodyLarge?.copyWith(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Row(
                              children: [
                                Text("Color: Red"),
                                SizedBox(width: 8),
                                Text("Size: XL"),
                              ],
                            )
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.delete))
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "\$100",
                        style: TextStyle(
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
