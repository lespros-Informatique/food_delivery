import 'package:flutter/material.dart';
import 'package:woli/utils/colors.dart';
import 'package:woli/pages/home/food_page_body.dart';
import 'package:woli/utils/dimensions.dart';
import 'package:woli/widgets/big_text.dart';
import 'package:woli/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    Dimensions.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //showing the header
            Container(
              margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: 'Bangladesh', color: AppColors.mainColor),
                      Row(
                        children: [
                          SmallText(text: 'Narsingdi', color: Colors.black54),
                          Icon(Icons.arrow_drop_down_rounded),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor,
                    ),
                    child: Icon(Icons.search, color: Colors.white, size: Dimensions.iconSize24),
                  ),
                ],
              ),
            ),
            //showing the body
            FoodPageBody(),
          ],
        ),
      ),
    );
  }
}
