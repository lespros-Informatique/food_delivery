import 'package:flutter/material.dart';

class Dimensions {
  static double screenHeight = 844.0;
  static double screenWidth = 390.0;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenHeight = mediaQuery.size.height;
    screenWidth = mediaQuery.size.width;
  }

// for page view height
  static double get pageViewContainer => screenHeight / 3.84;
  static double get pageViewTextContainer => screenHeight / 5.5;
  static double get pageView => screenHeight / 2.64;

// for height and width padding and margin
  static double get height10 => screenHeight / 84.4;
  static double get height15 => screenHeight / 56.27;
  static double get height20 => screenHeight / 42.2;
  static double get height30 => screenHeight / 28.13;
  static double get height45 => screenHeight / 18.76;

//width
  static double get width10 => screenHeight / 84.4;
  static double get width15 => screenHeight / 56.27;
  static double get width20 => screenHeight / 42.2;
  static double get width30 => screenHeight / 28.13;

//radius
  static double get radius15 => screenHeight / 56.27;
  static double get radius20 => screenHeight / 42.2;
  static double get radius30 => screenHeight / 28.13;

//font size
  static double get font20 => screenHeight / 42.2;
  static double get font26 => screenHeight / 32.46;
  static double get font16 => screenHeight / 52.75;

//icon size
  static double get iconSize24 => screenHeight / 35.17;
  static double get iconSize16 => screenHeight / 52.75;

  //list view size
  static double get listViewImgSize => screenWidth / 3.25;
  static double get listViewTextContSize => screenWidth / 3.9;

  //popular food
  static double get popularFoodImgSize => screenHeight / 2.41;

  //bottom height
  static double get bottomHeightBar => screenHeight / 7.03;
}