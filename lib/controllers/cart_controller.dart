import 'package:woli/models/cart_model.dart';
import 'package:woli/models/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final Cart _cart = Cart();

  Cart get cart => _cart;

  void addToCart(ProductModel product, int quantity) {
    _cart.addItem(product, quantity);
    update();
  }

  void removeFromCart(int productId) {
    _cart.removeItem(productId);
    update();
  }

  void updateQuantity(int productId, int quantity) {
    _cart.updateQuantity(productId, quantity);
    update();
  }

  void clearCart() {
    _cart.clear();
    update();
  }

  bool isInCart(int productId) {
    return _cart.items.any((item) => item.product.id == productId);
  }

  int getQuantity(int productId) {
    final item = _cart.items.firstWhereOrNull((item) => item.product.id == productId);
    return item?.quantity ?? 0;
  }
}