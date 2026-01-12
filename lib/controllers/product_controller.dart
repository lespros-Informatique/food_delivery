import 'package:woli/data/repository/product_repo.dart';
import 'package:woli/models/products_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;

  ProductController({required this.productRepo});

  List<ProductModel> _productList = [];
  List<ProductModel> get productList => _productList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getProductsByRestaurant(String restaurantCode) async {
    _isLoaded = false;
    update();
    try {
      List<ProductModel> products = await productRepo.getProductsByRestaurant(restaurantCode);
      _productList = products;
      _isLoaded = true;
      update();
    } catch (e) {
      _isLoaded = true;
      update();
      // Handle error
    }
  }

  Future<void> getProductsByCategory(String categoryCode) async {
    _isLoaded = false;
    update();
    try {
      List<ProductModel> products = await productRepo.getProductsByCategory(categoryCode);
      _productList = products;
      _isLoaded = true;
      update();
    } catch (e) {
      _isLoaded = true;
      update();
      // Handle error
    }
  }

  ProductModel? getProductById(int id) {
    return _productList.firstWhereOrNull((p) => p.id == id);
  }
}