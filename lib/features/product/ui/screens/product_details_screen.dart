import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sum_app/app/app_colors.dart';
import 'package:sum_app/features/cart/ui/controllers/add_to_cart_controller.dart';
import 'package:sum_app/features/common/data/models/product_model.dart';
import 'package:sum_app/features/common/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:sum_app/features/common/ui/widgets/product_quantity_inc_dec_button.dart';
import 'package:sum_app/features/product/ui/controllers/product_details_controller.dart';
import 'package:sum_app/features/product/ui/widgets/color_picker_widget.dart';
import 'package:sum_app/features/product/ui/widgets/product_image_carousel_slider.dart';
import 'package:sum_app/features/product/ui/widgets/size_picker_widget.dart';
import 'package:sum_app/features/wishlist/ui/controllers/add_to_wishlist_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static const String name = '/product/product-details';
  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Product Details'),
      ),
      body: GetBuilder<ProductDetailsController>(builder: (controller) {
        if (controller.inProgress) {
          return const CenteredCircularProgressIndicator();
        }
        if (controller.errorMessage != null) {
          return Center(
            child: Text(controller.errorMessage!),
          );
        }

        Product? eachProductData = controller.productDetails;

        // print(eachProductData?.id);
        // print(widget.productId);

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    ProductImageCarouselSlider(
                      imageUrls: eachProductData?.photos ?? [],
                    ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      eachProductData?.title ?? '',
                                      textAlign: TextAlign.start,
                                      style: textTheme.titleMedium,
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${eachProductData?.v ?? ''}',
                                              style: const TextStyle(
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
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.find<
                                                      AddToWishlistController>()
                                                  .addToWishList(
                                                      eachProductData!.id! ??
                                                          '');
                                            },
                                            child: const Icon(
                                              Icons.favorite_border,
                                              size: 14,
                                              color: Colors.white,
                                            ),
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
                            colors: eachProductData?.colors ?? [],
                            onColorSelected: (String selectedColor) {},
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Size",
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          SizePickerWidget(
                            sizes: eachProductData?.sizes ?? [],
                            onSizeSelected: (String selectedSize) {},
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Description",
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            eachProductData?.description ?? '',
                            style: const TextStyle(
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
            buildPriceAndAddToCardSection(
                textTheme, eachProductData?.currentPrice.toString() ?? '0'),
          ],
        );
      }),
    );
  }

  Widget buildPriceAndAddToCardSection(TextTheme textTheme, String price) {
    Product? eachProductData =
        Get.find<ProductDetailsController>().productDetails;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Price",
                style: textTheme.titleSmall,
              ),
              Text(
                "\$$price",
                style: const TextStyle(
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
              onPressed: () {
                Get.find<AddToCartListController>()
                    .addToCartList(eachProductData!.id! ?? '');
              },
              child: const Text("Add to Cart"),
            ),
          ),
        ],
      ),
    );
  }
}
