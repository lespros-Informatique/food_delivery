import 'package:flutter/material.dart';
import 'package:woli/controllers/restaurant_controller.dart';
import 'package:woli/pages/food/popular_food_detail.dart';
import 'package:woli/pages/food/recommanded_food_detail.dart';
import 'package:woli/pages/main_navigation.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<RestaurantController>().getRestaurantList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Woli - Food Delivery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainNavigation(),
    );
  }
}
