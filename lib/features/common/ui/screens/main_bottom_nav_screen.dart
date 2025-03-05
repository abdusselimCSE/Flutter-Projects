import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sum_app/features/auth/ui/screens/sign_in_screen.dart';
import 'package:sum_app/features/cart/ui/screens/cart_list_screen.dart';
import 'package:sum_app/features/category/ui/screens/category_list_screen.dart';
import 'package:sum_app/features/common/ui/controllers/auth_controller.dart';
import 'package:sum_app/features/common/ui/controllers/category_list_controller.dart';
import 'package:sum_app/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:sum_app/features/home/ui/controllers/popular_product_listcontroller.dart';
import 'package:sum_app/features/home/ui/controllers/slider_list_controller.dart';
import 'package:sum_app/features/home/ui/screens/home_screen.dart';
import 'package:sum_app/features/wishlist/ui/screens/wish_list_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static const String name = '/bottom-nav-screen';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryListScreen(),
    const CartListScreen(),
    const WishListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Get.find<SliderListController>().getHomeSliders();
    Get.find<CategoryListController>().getCategoryList();
    Get.find<PopularProductListController>().getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(builder: (bottomNavController) {
      return Scaffold(
        body: _screens[bottomNavController.selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: bottomNavController.selectedIndex,
          onDestinationSelected: (index) async {
            final authController = Get.find<AuthController>();
            await authController
                .getUserData(); // Ensure the latest token is retrieved

            if (index == 3) {
              // ✅ Wishlist clicked
              if (authController.accessToken == null ||
                  authController.accessToken!.isEmpty ||
                  authController.accessToken!.contains("{")) {
                // Invalid token
                print(
                    "User not logged in OR Invalid token. Redirecting to login...");

                final result = await Get.to(() => const SignInScreen());

                if (result == true) {
                  print("User logged in. Navigating to Wishlist...");

                  // ✅ Ensure navigation is performed after build completes
                  Future.delayed(Duration.zero, () {
                    Get.find<MainBottomNavController>().changeIndex(3);
                  });
                }
                return;
              }
            }

            Get.find<MainBottomNavController>().changeIndex(index);
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.category), label: "Categories"),
            NavigationDestination(
                icon: Icon(Icons.shopping_cart), label: "Cart"),
            NavigationDestination(
                icon: Icon(Icons.favorite_border), label: "Wishlist"),
          ],
        ),
      );
    });
  }
}
