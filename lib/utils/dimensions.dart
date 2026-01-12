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
static double get height3 => screenHeight / 281.3;
static double get height5 => screenHeight / 168.8;
static double get height8 => screenHeight / 105.5;
static double get height10 => screenHeight / 84.4;
static double get height15 => screenHeight / 56.27;
static double get height18 => screenHeight / 46.89;
static double get height20 => screenHeight / 42.2;
static double get height25 => screenHeight / 33.76;
static double get height30 => screenHeight / 28.13;
static double get height40 => screenHeight / 21.1;
static double get height45 => screenHeight / 18.76;
static double get height50 => screenHeight / 16.88;

//width
static double get width3 => screenHeight / 281.3;
static double get width5 => screenHeight / 168.8;
static double get width9 => screenHeight / 93.78;
static double get width10 => screenHeight / 84.4;
static double get width15 => screenHeight / 56.27;
static double get width18 => screenHeight / 46.89;
static double get width20 => screenHeight / 42.2;
static double get width25 => screenHeight / 33.76;
static double get width30 => screenHeight / 28.13;
static double get width40 => screenHeight / 21.1;
static double get width60 => screenHeight / 14.07;
static double get width100 => screenHeight / 8.44;

//radius
  static double get radius5 => screenHeight / 168.8;
  static double get radius10 => screenHeight / 84.4;
  static double get radius15 => screenHeight / 56.27;
  static double get radius20 => screenHeight / 42.2;
  static double get radius25 => screenHeight / 33.76;
  static double get radius30 => screenHeight / 28.13;

//font size
  static double get font20 => screenHeight / 42.2;
  static double get font26 => screenHeight / 32.46;
  static double get font18 => screenHeight / 46.89;
  static double get font16 => screenHeight / 52.75;
  static double get font14 => screenHeight / 60.29;
  static double get font12 => screenHeight / 70.33;
  static double get font11 => screenHeight / 77.09;
  static double get font10 => screenHeight / 84.4;

//icon size
  static double get iconSize24 => screenHeight / 35.17;
  static double get iconSize20 => screenHeight / 42.2;
  static double get iconSize16 => screenHeight / 52.75;
  static double get iconSize14 => screenHeight / 60.29;
  static double get iconSize28 => screenHeight / 30.14;
  static double get iconSize50 => screenHeight / 16.88;
  static double get iconSize60 => screenHeight / 14.07;
  static double get iconSize100 => screenHeight / 8.44;

  //list view size
  static double get listViewImgSize => screenWidth / 3.25;
  static double get listViewTextContSize => screenWidth / 3.9;

  //popular food
  static double get popularFoodImgSize => screenHeight / 2.41;

  //bottom height
  static double get bottomHeightBar => screenHeight / 7.03;
}