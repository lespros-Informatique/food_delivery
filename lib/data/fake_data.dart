import 'package:woli/models/restaurant_model.dart';
import 'package:woli/models/category_model.dart';
import 'package:woli/models/products_model.dart';
import 'package:woli/models/order_model.dart';
import 'package:woli/models/user_model.dart';

// Fake Restaurants
List<Restaurant> fakeRestaurants = [
  Restaurant(
    idRestaurant: 1,
    codeRestaurant: 'RES-DEMO-001',
    nomRestaurant: 'Woli Burger',
    description: 'Le meilleur burger de la ville',
    adresse: '123 Rue de la Paix',
    ville: 'Dakar',
    logo: null,
    statut: 1,
    latitude: 14.6937,
    longitude: -17.4441,
    createdAt: '2025-12-20 15:21:05',
    updatedAt: '2025-12-24 08:48:02',
  ),
  Restaurant(
    idRestaurant: 2,
    codeRestaurant: 'RES-ITALIAN-001',
    nomRestaurant: 'Pizza Italia',
    description: 'Authentic Italian pizzas made with fresh ingredients',
    adresse: '456 Avenue des Italiens',
    ville: 'Dakar',
    logo: null,
    statut: 1,
    latitude: 14.6950,
    longitude: -17.4460,
    createdAt: '2025-12-21 10:00:00',
    updatedAt: '2025-12-21 10:00:00',
  ),
  Restaurant(
    idRestaurant: 3,
    codeRestaurant: 'RES-ASIAN-001',
    nomRestaurant: 'Sakura Sushi',
    description: 'Fresh sushi and Asian cuisine',
    adresse: '789 Boulevard Asiatique',
    ville: 'Dakar',
    logo: null,
    statut: 1,
    latitude: 14.6970,
    longitude: -17.4480,
    createdAt: '2025-12-22 12:00:00',
    updatedAt: '2025-12-22 12:00:00',
  ),
];

// Fake Categories
List<Category> fakeCategories = [
  Category(
    idCategorie: 1,
    codeCategorie: 'CAT-BURGER',
    restaurantCode: 'RES-DEMO-001',
    nomCategorie: 'Burgers',
    ordre: 0,
    statut: 1,
  ),
  Category(
    idCategorie: 2,
    codeCategorie: 'CAT-PIZZA',
    restaurantCode: 'RES-ITALIAN-001',
    nomCategorie: 'Pizzas',
    ordre: 0,
    statut: 1,
  ),
  Category(
    idCategorie: 3,
    codeCategorie: 'CAT-SUSHI',
    restaurantCode: 'RES-ASIAN-001',
    nomCategorie: 'Sushi',
    ordre: 0,
    statut: 1,
  ),
  Category(
    idCategorie: 4,
    codeCategorie: 'CAT-DESSERTS',
    restaurantCode: 'RES-DEMO-001',
    nomCategorie: 'Desserts',
    ordre: 1,
    statut: 1,
  ),
];

// Fake Products
List<ProductModel> fakeProducts = [
  ProductModel(
    id: 1,
    name: 'Cheeseburger',
    description: 'Delicious cheese burger with fresh ingredients',
    price: 5000,
    stars: 4,
    img: 'assets/image/food15.jpg',
    location: 'Dakar',
    createdAt: '2025-12-20 15:29:18',
    updatedAt: '2025-12-20 15:29:18',
    typeId: 2,
  ),
  ProductModel(
    id: 2,
    name: 'Margherita Pizza',
    description: 'Classic pizza with tomato sauce, mozzarella and basil',
    price: 8000,
    stars: 5,
    img: 'assets/image/food16.jpg',
    location: 'Dakar',
    createdAt: '2025-12-21 10:30:00',
    updatedAt: '2025-12-21 10:30:00',
    typeId: 2,
  ),
  ProductModel(
    id: 3,
    name: 'California Roll',
    description: 'Fresh sushi roll with avocado and crab',
    price: 6000,
    stars: 4,
    img: 'assets/image/food2.png',
    location: 'Dakar',
    createdAt: '2025-12-22 12:30:00',
    updatedAt: '2025-12-22 12:30:00',
    typeId: 2,
  ),
  ProductModel(
    id: 4,
    name: 'Chicken Burger',
    description: 'Grilled chicken burger with lettuce and mayo',
    price: 5500,
    stars: 4,
    img: 'assets/image/food3.png',
    location: 'Dakar',
    createdAt: '2025-12-20 16:00:00',
    updatedAt: '2025-12-20 16:00:00',
    typeId: 2,
  ),
  ProductModel(
    id: 5,
    name: 'Chocolate Cake',
    description: 'Rich chocolate cake with vanilla frosting',
    price: 3000,
    stars: 5,
    img: 'assets/image/food4.png',
    location: 'Dakar',
    createdAt: '2025-12-20 16:30:00',
    updatedAt: '2025-12-20 16:30:00',
    typeId: 2,
  ),
];

// Helper functions to get data by restaurant
List<Category> getCategoriesByRestaurant(String restaurantCode) {
  return fakeCategories.where((cat) => cat.restaurantCode == restaurantCode).toList();
}

List<ProductModel> getProductsByRestaurant(String restaurantCode) {
  return fakeProducts.where((prod) => 
    fakeCategories.any((cat) => 
      cat.restaurantCode == restaurantCode && 
      cat.codeCategorie == getCategoryCodeForProduct(prod.id!)
    )
  ).toList();
}

List<ProductModel> getProductsByCategory(String categoryCode) {
  // For simplicity, we'll assume products belong to categories based on some logic
  // In real app, products would have category_code field
  return fakeProducts; // Return all for now
}

String? getCategoryCodeForProduct(int productId) {
  // Mock logic - in real app, products have category_code
  if (productId == 1 || productId == 4) return 'CAT-BURGER';
  if (productId == 2) return 'CAT-PIZZA';
  if (productId == 3) return 'CAT-SUSHI';
  if (productId == 5) return 'CAT-DESSERTS';
  return null;
}

// Fake User
User fakeUser = User(
  id: 1,
  name: 'Jean Dupont',
  email: 'jean.dupont@example.com',
  phone: '+221 77 123 45 67',
  address: '123 Rue de la Liberté, Dakar, Sénégal',
  profileImage: null,
);

// Fake Orders
List<Order> fakeOrders = [
  Order(
    id: 1,
    codeCommande: 'CMD-DEMO-001',
    restaurantCode: 'RES-DEMO-001',
    clientCode: 'CLI-DEMO-001',
    totalCommande: 15500.00,
    statutCommande: 'livree',
    createdAt: DateTime(2025, 12, 25, 12, 30),
    restaurantName: 'Woli Burger',
    clientName: 'John Doe',
    items: [
      OrderLine(
        id: 1,
        codeCommandeLigne: 'LIG-001',
        commandeCode: 'CMD-DEMO-001',
        produitCode: 'PROD-CHEESE',
        quantite: 2,
        prixUnitaire: 5000.00,
        totalLigne: 10000.00,
        productName: 'Cheeseburger',
        productImage: 'assets/image/food0.png',
      ),
      OrderLine(
        id: 2,
        codeCommandeLigne: 'LIG-002',
        commandeCode: 'CMD-DEMO-001',
        produitCode: 'PROD-CHICKEN',
        quantite: 1,
        prixUnitaire: 5500.00,
        totalLigne: 5500.00,
        productName: 'Chicken Burger',
        productImage: 'assets/image/food3.png',
      ),
    ],
  ),
  Order(
    id: 2,
    codeCommande: 'CMD-DEMO-002',
    restaurantCode: 'RES-ITALIAN-001',
    clientCode: 'CLI-DEMO-001',
    totalCommande: 8000.00,
    statutCommande: 'livree',
    createdAt: DateTime(2025, 12, 24, 19, 15),
    restaurantName: 'Pizza Italia',
    clientName: 'John Doe',
    items: [
      OrderLine(
        id: 3,
        codeCommandeLigne: 'LIG-003',
        commandeCode: 'CMD-DEMO-002',
        produitCode: 'PROD-PIZZA',
        quantite: 1,
        prixUnitaire: 8000.00,
        totalLigne: 8000.00,
        productName: 'Margherita Pizza',
        productImage: 'assets/image/food1.png',
      ),
    ],
  ),
  Order(
    id: 3,
    codeCommande: 'CMD-DEMO-003',
    restaurantCode: 'RES-ASIAN-001',
    clientCode: 'CLI-DEMO-001',
    totalCommande: 15000.00,
    statutCommande: 'en_preparation',
    createdAt: DateTime(2025, 12, 23, 14, 45),
    restaurantName: 'Sakura Sushi',
    clientName: 'John Doe',
    items: [
      OrderLine(
        id: 4,
        codeCommandeLigne: 'LIG-004',
        commandeCode: 'CMD-DEMO-003',
        produitCode: 'PROD-SUSHI',
        quantite: 2,
        prixUnitaire: 6000.00,
        totalLigne: 12000.00,
        productName: 'California Roll',
        productImage: 'assets/image/food2.png',
      ),
      OrderLine(
        id: 5,
        codeCommandeLigne: 'LIG-005',
        commandeCode: 'CMD-DEMO-003',
        produitCode: 'PROD-CAKE',
        quantite: 1,
        prixUnitaire: 3000.00,
        totalLigne: 3000.00,
        productName: 'Chocolate Cake',
        productImage: 'assets/image/food4.png',
      ),
    ],
  ),
  Order(
    id: 4,
    codeCommande: 'CMD-DEMO-004',
    restaurantCode: 'RES-DEMO-001',
    clientCode: 'CLI-DEMO-001',
    totalCommande: 11000.00,
    statutCommande: 'annulee',
    createdAt: DateTime(2025, 12, 22, 20, 00),
    restaurantName: 'Woli Burger',
    clientName: 'John Doe',
    items: [
      OrderLine(
        id: 6,
        codeCommandeLigne: 'LIG-006',
        commandeCode: 'CMD-DEMO-004',
        produitCode: 'PROD-CHEESE',
        quantite: 1,
        prixUnitaire: 5000.00,
        totalLigne: 5000.00,
        productName: 'Cheeseburger',
        productImage: 'assets/image/food0.png',
      ),
      OrderLine(
        id: 7,
        codeCommandeLigne: 'LIG-007',
        commandeCode: 'CMD-DEMO-004',
        produitCode: 'PROD-CAKE',
        quantite: 2,
        prixUnitaire: 3000.00,
        totalLigne: 6000.00,
        productName: 'Chocolate Cake',
        productImage: 'assets/image/food4.png',
      ),
    ],
  ),
];