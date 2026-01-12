import 'package:flutter/material.dart';
import 'package:woli/utils/app_icon.dart';
import 'package:woli/utils/colors.dart';
import 'package:woli/utils/dimensions.dart';
import 'package:woli/widgets/big_text.dart';
import 'package:woli/widgets/expandable_text_widget.dart';

class RecommandedFoodDetail extends StatelessWidget {
  const RecommandedFoodDetail({super.key});

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
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                  child: BigText(
                    text: "Gridded Flash Flood Guidance",
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
                "assets/image/food0.png",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                children: [
                  Container(
                    child: ExpandableTextWidget(
                      text:
                          "Gridded Flash Flood Guidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance Guidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (MiscellaGuidance (Miscella(Miscellaneous » Unclassified): Could refer to a technical system for monitoring or predicting flash floods.\nGood Food for Good (Miscellaneous » Food & Nutrition): A socially-driven or community initiative focused on food quality or nutrition.",
                    ),
                    margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                  ),
                  // expandable text widget
                ],
              ),
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              margin: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: Dimensions.height10,
              bottom: Dimensions.height10,
              left: Dimensions.width20 * 2.5,
              right: Dimensions.width20 * 2.5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  iconSize: Dimensions.iconSize24,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  icon: Icons.remove,
                ),

                BigText(
                  text: "\$10 X 0",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font26,
                ),

                AppIcon(
                  iconSize: Dimensions.iconSize24,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  icon: Icons.add,
                ),
              ],
            ),
          ),
          // Bottom Navigation Bar
          Container(
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

                  child: Icon(Icons.favorite, 
                  color: AppColors.mainColor,
                  size: Dimensions.iconSize24,
                  ),
                ),

                Container(
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

                  child: BigText(
                    text: "\$10 | Add to cart",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
