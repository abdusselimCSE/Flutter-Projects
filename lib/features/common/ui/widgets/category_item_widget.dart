import 'package:flutter/material.dart';
import 'package:sum_app/app/app_colors.dart';
import 'package:sum_app/features/common/data/models/category_model.dart';
import 'package:sum_app/features/product/ui/screens/product_list_screen.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.categoryModel,
  });

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductListScreen.name,
            arguments: "Computer");
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.themeColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              categoryModel.categoryImg ?? '',
              height: 40,
              width: 40,
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            categoryModel.categoryName ?? '',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.themeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
