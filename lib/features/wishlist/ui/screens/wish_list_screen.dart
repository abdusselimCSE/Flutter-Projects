import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/ui/screens/controllers/main_bottom_nav_controller.dart';
import '../../../common/ui/widgets/product_item_widget.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _onPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("WishList"),
          leading:
              IconButton(onPressed: _onPop, icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              crossAxisSpacing: 2,
              mainAxisSpacing: 4,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              return const FittedBox(child: ProductItemWidget());
            },
          ),
        ),
      ),
    );
  }

  void _onPop() {
    Get.find<MainBottomNavController>().backToHome();
  }
}
