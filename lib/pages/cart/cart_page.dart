import 'package:flutter/material.dart';
import 'package:woli/controllers/cart_controller.dart';
import 'package:woli/models/cart_model.dart';
import 'package:woli/utils/colors.dart';
import 'package:woli/utils/dimensions.dart';
import 'package:woli/widgets/big_text.dart';
import 'package:woli/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:woli/pages/checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Votre Panier", color: Colors.white),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: GetBuilder<CartController>(builder: (cartController) {
        if (cartController.cart.items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 100, color: AppColors.signColor),
                SizedBox(height: Dimensions.height20),
                BigText(text: "Votre panier est vide", color: AppColors.signColor),
                SizedBox(height: Dimensions.height10),
                SmallText(text: "Ajoutez des produits pour commencer"),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Cart items
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cart.items.length,
                itemBuilder: (context, index) {
                  CartItem item = cartController.cart.items[index];
                  return Container(
                    margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.height15,
                      bottom: Dimensions.height10,
                    ),
                    padding: EdgeInsets.all(Dimensions.width15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFe8e8e8),
                          blurRadius: 5.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Product image
                        Container(
                          width: Dimensions.listViewImgSize / 1.8,
                          height: Dimensions.listViewImgSize / 1.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(item.product.img ?? "assets/image/food0.png"),
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.width15),
                        // Product details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BigText(text: item.product.name ?? "Product", size: Dimensions.font16),
                              SizedBox(height: Dimensions.height5),
                              SmallText(text: "${item.product.price ?? 0} FCFA"),
                              SizedBox(height: Dimensions.height10),
                              // Quantity controls
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (item.quantity > 1) {
                                        cartController.updateQuantity(item.product.id!, item.quantity - 1);
                                      } else {
                                        cartController.removeFromCart(item.product.id!);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(Dimensions.width5),
                                      decoration: BoxDecoration(
                                        color: AppColors.mainColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(Dimensions.radius10),
                                      ),
                                      child: Icon(Icons.remove, color: AppColors.mainColor, size: Dimensions.iconSize20),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height5),
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                                    ),
                                    child: BigText(text: item.quantity.toString(), color: AppColors.mainColor),
                                  ),
                                  SizedBox(width: Dimensions.width10),
                                  GestureDetector(
                                    onTap: () {
                                      cartController.updateQuantity(item.product.id!, item.quantity + 1);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(Dimensions.width5),
                                      decoration: BoxDecoration(
                                        color: AppColors.mainColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(Dimensions.radius10),
                                      ),
                                      child: Icon(Icons.add, color: AppColors.mainColor, size: Dimensions.iconSize20),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: Dimensions.width10),
                        // Remove button
                        GestureDetector(
                          onTap: () => cartController.removeFromCart(item.product.id!),
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.width10),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(Dimensions.radius10),
                            ),
                            child: Icon(Icons.delete, color: Colors.red, size: Dimensions.iconSize20),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Bottom total and checkout
            Container(
              margin: EdgeInsets.only(top: Dimensions.height20),
              padding: EdgeInsets.all(Dimensions.width20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 10.0,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(text: "Total à payer", color: AppColors.paraColor),
                          SizedBox(height: Dimensions.height5),
                          BigText(
                            text: "${cartController.cart.totalAmount.toStringAsFixed(0)} FCFA",
                            color: AppColors.mainColor,
                            size: Dimensions.font20,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const CheckoutPage());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width30,
                            vertical: Dimensions.height15,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.mainColor.withOpacity(0.3),
                                blurRadius: 5.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: BigText(text: "Commander", color: Colors.white, size: Dimensions.font16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}