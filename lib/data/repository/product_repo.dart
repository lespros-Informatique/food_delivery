import 'package:woli/data/api/api_client.dart';
import 'package:woli/data/fake_data.dart';
import 'package:woli/models/products_model.dart';
import 'package:get/get.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;

  ProductRepo({required this.apiClient});

  Future<List<ProductModel>> getProductsByRestaurant(String restaurantCode) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _getProductsByRestaurantFromFakeData(restaurantCode);
  }

  List<ProductModel> _getProductsByRestaurantFromFakeData(String restaurantCode) {
    return fakeProducts.where((prod) =>
      fakeCategories.any((cat) =>
        cat.restaurantCode == restaurantCode &&
        cat.codeCategorie == getCategoryCodeForProduct(prod.id!)
      )
    ).toList();
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryCode) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return getProductsByCategory(categoryCode);
  }

  Future<ProductModel?> getProductById(int id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return fakeProducts.firstWhereOrNull((p) => p.id == id);
  }
}