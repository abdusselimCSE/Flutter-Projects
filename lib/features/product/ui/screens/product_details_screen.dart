import 'package:flutter/material.dart';
import 'package:sum_app/features/product/ui/widgets/color_picker_widget.dart';

import '../../../../app/app_colors.dart';
import '../widgets/product_image_carousel_slider.dart';
import '../widgets/product_quantity_inc_dec_button.dart';
import '../widgets/size_picker_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static const String name = '/product/product-details';
  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Product Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const ProductImageCarouselSlider(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Nike Shoe A2ERF - New Year special deal",
                                    style: textTheme.titleMedium,
                                  ),
                                  Row(
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 18,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "4.5",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text("Reviews"),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: AppColors.themeColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: const Icon(
                                          Icons.favorite_border,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            ProductQuantityIncDecButton(
                              onChange: (int value) {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Color",
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        ColorPickerWidget(
                          colors: const ['Red', 'Green', 'Yellow', 'Pink'],
                          onColorSelected: (String selectedColor) {},
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Size",
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        SizePickerWidget(
                          sizes: const ['S', 'M', 'L', 'XL'],
                          onSizeSelected: (String selectedSize) {},
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Description",
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.''',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          buildPriceAndAddToCardSection(textTheme),
        ],
      ),
    );
  }

  Widget buildPriceAndAddToCardSection(TextTheme textTheme) {
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
                "Price",
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
              child: const Text("Add to Cart"),
            ),
          ),
        ],
      ),
    );
  }
}
