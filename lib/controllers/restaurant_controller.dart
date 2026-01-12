import 'package:woli/data/repository/restaurant_repo.dart';
import 'package:woli/models/restaurant_model.dart';
import 'package:get/get.dart';

class RestaurantController extends GetxController {
  final RestaurantRepo restaurantRepo;

  RestaurantController({required this.restaurantRepo});

  List<Restaurant> _restaurantList = [];
  List<Restaurant> get restaurantList => _restaurantList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRestaurantList() async {
    _isLoaded = false;
    update();
    try {
      List<Restaurant> restaurants = await restaurantRepo.getRestaurantList();
      _restaurantList = restaurants;
      _isLoaded = true;
      update();
    } catch (e) {
      _isLoaded = true;
      update();
      // Handle error
    }
  }

  Restaurant? getRestaurantByCode(String code) {
    return _restaurantList.firstWhereOrNull((r) => r.codeRestaurant == code);
  }
}