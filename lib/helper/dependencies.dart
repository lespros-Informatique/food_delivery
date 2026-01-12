import 'package:woli/controllers/cart_controller.dart';
import 'package:woli/controllers/popular_product_controller.dart';
import 'package:woli/controllers/product_controller.dart';
import 'package:woli/controllers/restaurant_controller.dart';
import 'package:woli/data/api/api_client.dart';
import 'package:woli/data/repository/popular_product_repo.dart';
import 'package:woli/data/repository/product_repo.dart';
import 'package:woli/data/repository/restaurant_repo.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

Future<void> init()async {
  // Api Client
  Get.lazyPut(() => ApiClient(appBaseUrl: "https://api.example.com"));

  // Repositories
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RestaurantRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));

  // Controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RestaurantController(restaurantRepo: Get.find()));
  Get.lazyPut(() => ProductController(productRepo: Get.find()));
  Get.lazyPut(() => CartController());
}