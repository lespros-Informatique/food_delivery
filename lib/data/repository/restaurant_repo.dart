import 'package:woli/data/api/api_client.dart';
import 'package:woli/data/fake_data.dart';
import 'package:woli/models/restaurant_model.dart';
import 'package:get/get.dart';

class RestaurantRepo extends GetxService {
  final ApiClient apiClient;

  RestaurantRepo({required this.apiClient});

  Future<List<Restaurant>> getRestaurantList() async {
    // For now, return fake data
    // In real app: Response response = await apiClient.getData("restaurants");
    // return response.body.map((json) => Restaurant.fromJson(json)).toList();
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    return fakeRestaurants;
  }

  Future<Restaurant?> getRestaurantById(String code) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return fakeRestaurants.firstWhereOrNull((r) => r.codeRestaurant == code);
  }
}