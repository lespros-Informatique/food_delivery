import 'package:flutter/material.dart';
import 'package:woli/controllers/cart_controller.dart';
import 'package:woli/pages/cart/cart_page.dart';
import 'package:woli/pages/home/main_food_page.dart';
import 'package:woli/pages/orders/orders_page.dart';
import 'package:woli/pages/profile/profile_page.dart';
import 'package:woli/utils/colors.dart';
import 'package:woli/utils/dimensions.dart';
import 'package:woli/widgets/small_text.dart';
import 'package:get/get.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MainFoodPage(),
    OrdersPage(),
    CartPage(),
    ProfilePage(),
  ];

  final List<IconData> _icons = [
    Icons.restaurant_menu,
    Icons.local_shipping,
    Icons.shopping_cart,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBar + 10,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20),
            topRight: Radius.circular(Dimensions.radius20),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFe8e8e8),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_icons.length, (index) {
            bool isSelected = _currentIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10,
                  vertical: Dimensions.height10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.mainColor.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                ),
                child: index == 2
                    ? Builder(
                        builder: (context) {
                          try {
                            return GetBuilder<CartController>(
                              builder: (cartController) {
                                return Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Icon(
                                      _icons[index],
                                      color: isSelected ? AppColors.mainColor : AppColors.signColor,
                                      size: isSelected ? Dimensions.iconSize28 : Dimensions.iconSize24,
                                    ),
                                    if (cartController.cart.totalItems > 0)
                                      Positioned(
                                        right: -8,
                                        top: -8,
                                        child: Container(
                                          width: Dimensions.width18,
                                          height: Dimensions.height18,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(Dimensions.width9),
                                            border: Border.all(color: Colors.white, width: 2),
                                          ),
                                          child: Center(
                                            child: SmallText(
                                              text: cartController.cart.totalItems.toString(),
                                              color: Colors.white,
                                              size: Dimensions.font10,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            );
                          } catch (e) {
                            // Fallback if controller is not available
                            return Icon(
                              _icons[index],
                              color: isSelected ? AppColors.mainColor : AppColors.signColor,
                              size: isSelected ? Dimensions.iconSize28 : Dimensions.iconSize24,
                            );
                          }
                        },
                      )
                    : Icon(
                        _icons[index],
                        color: isSelected ? AppColors.mainColor : AppColors.signColor,
                        size: isSelected ? Dimensions.iconSize28 : Dimensions.iconSize24,
                      ),
              ),
            );
          }),
        ),
      ),
    );
  }
}