import 'package:flutter/material.dart';
import 'package:woli/controllers/product_controller.dart';
import 'package:woli/models/category_model.dart';
import 'package:woli/models/restaurant_model.dart';
import 'package:woli/pages/food/product_detail_page.dart';
import 'package:woli/utils/colors.dart';
import 'package:woli/utils/dimensions.dart';
import 'package:woli/widgets/big_text.dart';
import 'package:woli/widgets/small_text.dart';
import 'package:get/get.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    // Ensure ProductController is initialized
    if (!Get.isRegistered<ProductController>()) {
      Get.put(ProductController(productRepo: Get.find()));
    }
    // Load products for this restaurant
    Get.find<ProductController>().getProductsByRestaurant(widget.restaurant.codeRestaurant!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.width10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Dimensions.width10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: Icon(Icons.favorite_border, color: Colors.black),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                  child: BigText(
                    text: widget.restaurant.nomRestaurant ?? "Restaurant",
                    size: Dimensions.font26,
                  ),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/image/food${(widget.restaurant.idRestaurant! % 16) + 1}.png",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Restaurant info
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: AppColors.iconColor1, size: Dimensions.iconSize24),
                          SizedBox(width: Dimensions.width10),
                          BigText(text: "4.5"),
                          SizedBox(width: Dimensions.width20),
                          Icon(Icons.location_on, color: AppColors.mainColor, size: Dimensions.iconSize24),
                          SizedBox(width: Dimensions.width10),
                          SmallText(text: widget.restaurant.ville ?? "Ville"),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10),
                      SmallText(text: widget.restaurant.description ?? "Description du restaurant"),
                    ],
                  ),
                ),

                // Categories
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: Dimensions.height20),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3, // For demo, we'll show some categories
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(left: index == 0 ? Dimensions.width20 : Dimensions.width10),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedCategoryIndex = index;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedCategoryIndex == index
                                ? AppColors.mainColor
                                : Colors.white,
                            foregroundColor: _selectedCategoryIndex == index
                                ? Colors.white
                                : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                            ),
                          ),
                          child: Text(["Burgers", "Pizzas", "Sushi"][index]),
                        ),
                      );
                    },
                  ),
                ),

                // Products
                GetBuilder<ProductController>(builder: (productController) {
                  return productController.isLoaded
                      ? Container(
                          margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            top: Dimensions.height20,
                          ),
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: Dimensions.width10,
                              mainAxisSpacing: Dimensions.height10,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: productController.productList.length,
                            itemBuilder: (context, index) {
                               final product = productController.productList[index];
                               return GestureDetector(
                                 onTap: () => Get.to(() => ProductDetailPage(product: product)),
                                 child: Container(
                                   margin: EdgeInsets.all(Dimensions.width5),
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
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       // Product image
                                       Container(
                                         height: Dimensions.height20 * 6, // 120 approx
                                         width: double.infinity,
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.only(
                                             topLeft: Radius.circular(Dimensions.radius15),
                                             topRight: Radius.circular(Dimensions.radius15),
                                           ),
                                           image: DecorationImage(
                                             fit: BoxFit.cover,
                                             image: AssetImage(product.img ?? "assets/image/food0.png"),
                                           ),
                                         ),
                                       ),
                                       // Product info
                                       Padding(
                                         padding: EdgeInsets.all(Dimensions.width10),
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             BigText(
                                               text: product.name ?? "Produit",
                                               size: Dimensions.font14,
                                             ),
                                             SizedBox(height: Dimensions.height5),
                                             SmallText(text: "${(product.price ?? 0).toInt()} FCFA"),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               );
                             },
                          ),
                        )
                      : CircularProgressIndicator(color: AppColors.mainColor);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}