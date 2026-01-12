import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:woli/controllers/restaurant_controller.dart';
import 'package:woli/models/restaurant_model.dart';
import 'package:woli/pages/restaurant/restaurant_detail_page.dart';
import 'package:woli/utils/colors.dart';
import 'package:woli/widgets/app_column.dart';
import 'package:woli/widgets/icon_and_text_widget.dart';
import 'package:woli/utils/dimensions.dart';
import 'package:woli/widgets/big_text.dart';
import 'package:woli/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        GetBuilder<RestaurantController>(builder: (restaurantController) {
          return SizedBox(
            height: Dimensions.pageView,
            child: PageView.builder(
              controller: pageController,
              itemCount: restaurantController.restaurantList.length > 5
                  ? 5
                  : restaurantController.restaurantList.length,
              itemBuilder: (context, position) {
                return _buildPageItem(position, restaurantController.restaurantList[position]);
              },
            ),
          );
        }),

        GetBuilder<RestaurantController>(builder: (restaurantController) {
          int dotsCount = restaurantController.restaurantList.length > 5
              ? 5
              : restaurantController.restaurantList.length;
          return DotsIndicator(
            dotsCount: dotsCount > 0 ? dotsCount : 1,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          );
        }),

        //restaurants text
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Restaurants"),
              SizedBox(width: Dimensions.width10),

              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26),
              ),

              SizedBox(width: Dimensions.width10),

              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Near you"),
              ),
            ],
          ),
        ),
        //list of restaurants
        SizedBox(height: Dimensions.height20),
        GetBuilder<RestaurantController>(builder: (restaurantController) {
          return restaurantController.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: restaurantController.restaurantList.length,
                  itemBuilder: (context, index) {
                    Restaurant restaurant = restaurantController.restaurantList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => RestaurantDetailPage(restaurant: restaurant));
                      },
                      child: Container(
                      margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10,
                      ),
                      child: Row(
                        children: [
                          //image section
                          Container(
                            width: Dimensions.listViewImgSize,
                            height: Dimensions.listViewImgSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white38,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/image/food${(index % 16) + 1}.png"),
                              ),
                            ),
                          ),
                          //text container
                          Expanded(
                            child: Container(
                              height: Dimensions.listViewTextContSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensions.radius20),
                                  bottomRight: Radius.circular(Dimensions.radius20),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: restaurant.nomRestaurant ?? "Restaurant"),
                                    SizedBox(height: Dimensions.height10),
                                    SmallText(text: restaurant.description ?? "Description"),
                                    SizedBox(height: Dimensions.height10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndTextWidget(
                                          icon: Icons.star,
                                          text: "4.5",
                                          iconColor: AppColors.iconColor1,
                                        ),
                                        IconAndTextWidget(
                                          icon: Icons.location_on,
                                          text: restaurant.ville ?? "Ville",
                                          iconColor: AppColors.mainColor,
                                        ),
                                        IconAndTextWidget(
                                          icon: Icons.access_time_rounded,
                                          text: "25min",
                                          iconColor: AppColors.iconColor2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    );
                  },
                )
              : CircularProgressIndicator(color: AppColors.mainColor);
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, Restaurant restaurant) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = _scaleFactor;
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () {
          Get.to(() => RestaurantDetailPage(restaurant: restaurant));
        },
        child: Stack(
          children: [
            Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/image/food${(index % 16) + 1}.png"),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,

                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: 15,
                    right: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: restaurant.nomRestaurant ?? "Restaurant",
                        size: Dimensions.font20,
                      ),
                      SizedBox(height: Dimensions.height10),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.iconColor1,
                            size: Dimensions.iconSize16,
                          ),
                          SizedBox(width: Dimensions.width5),
                          SmallText(text: "4.5"),
                          SizedBox(width: Dimensions.width10),
                          Icon(
                            Icons.location_on,
                            color: AppColors.mainColor,
                            size: Dimensions.iconSize16,
                          ),
                          SizedBox(width: Dimensions.width5),
                          SmallText(text: restaurant.ville ?? "Ville"),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10),
                      SmallText(
                        text: restaurant.description ?? "Description du restaurant",
                        size: Dimensions.font12,
                        color: AppColors.paraColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

