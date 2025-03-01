import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sum_app/features/common/ui/controllers/category_list_controller.dart';
import 'package:sum_app/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:sum_app/features/common/ui/widgets/category_item_widget.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  static const String name = '/category-list-screen';

  @override
  Widget build(BuildContext context) {
    /*
    * popscope used to restrict back button closes the app completely
    * */
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _onPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Category List"),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: _onPop,
          ),
        ),
        body: RefreshIndicator(
          notificationPredicate: (_) => true,
          onRefresh: () async {
            await Get.find<CategoryListController>().getCategoryList();
          },
          child: GetBuilder<CategoryListController>(builder: (controller) {
            if (controller.inProgress) {
              return _buildShimmerEffect(controller);
            }
            return GridView.builder(
              itemCount: controller.categoryList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return FittedBox(
                  child: CategoryItemWidget(
                      categoryModel: controller.categoryList[index]),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _buildShimmerEffect(CategoryListController controller) {
    return GridView.builder(
      itemCount: controller.categoryList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }

  void _onPop() {
    Get.find<MainBottomNavController>().backToHome();
  }
}
