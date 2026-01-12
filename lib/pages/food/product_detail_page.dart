import 'package:flutter/material.dart';
import 'package:woli/controllers/cart_controller.dart';
import 'package:woli/models/products_model.dart';
import 'package:woli/pages/cart/cart_page.dart';
import 'package:woli/utils/app_icon.dart';
import 'package:woli/utils/colors.dart';
import 'package:woli/utils/dimensions.dart';
import 'package:woli/widgets/app_column.dart';
import 'package:woli/widgets/big_text.dart';
import 'package:woli/widgets/expandable_text_widget.dart';
import 'package:woli/widgets/small_text.dart';
import 'package:get/get.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // product image section
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(widget.product.img ?? "assets/image/food0.png"),
                ),
              ),
            ),
          ),
          // icon widget section
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: AppIcon(icon: Icons.arrow_back_ios),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => CartPage()),
                  child: GetBuilder<CartController>(builder: (cartController) {
                    return Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        cartController.cart.totalItems > 0
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: SmallText(
                                      text: cartController.cart.totalItems.toString(),
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
          // introduction of product
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: widget.product.name ?? "Product"),

                  SizedBox(height: Dimensions.height20),

                  BigText(text: "Description"),

                  SizedBox(height: Dimensions.height20),

                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                        text: widget.product.description ?? "No description available.",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // expandable text widget
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(
            top: Dimensions.height30,
            bottom: Dimensions.height30,
            left: Dimensions.width20,
            right: Dimensions.width20,
          ),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20 * 2),
              topRight: Radius.circular(Dimensions.radius20 * 2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_quantity > 1) {
                          setState(() {
                            _quantity--;
                          });
                        }
                      },
                      child: Icon(Icons.remove, color: AppColors.signColor),
                    ),
                    SizedBox(width: Dimensions.width10 / 2),
                    BigText(text: _quantity.toString()),
                    SizedBox(width: Dimensions.width10 / 2),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _quantity++;
                        });
                      },
                      child: Icon(Icons.add, color: AppColors.signColor),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  cartController.addToCart(widget.product, _quantity);
                  Get.snackbar(
                    "Ajouté au panier",
                    "${widget.product.name} x$_quantity ajouté",
                    backgroundColor: AppColors.mainColor,
                    colorText: Colors.white,
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: Dimensions.screenWidth * 0.4),
                    child: BigText(
                      text: "${((widget.product.price ?? 0) * _quantity).toInt()} FCFA",
                      color: Colors.white,
                      size: Dimensions.font14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}