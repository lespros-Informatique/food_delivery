import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

Future<void> init()async {
  // Api Client
Get.lazyPut(() => ApiClient(appBaseUrl: "https://api.example.com"));

// Repositories
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  
// Controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}