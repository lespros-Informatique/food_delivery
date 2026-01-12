
class Order {
  final int id;
  final String codeCommande;
  final String restaurantCode;
  final String clientCode;
  final double totalCommande;
  final String statutCommande; // 'en_attente','payee','en_preparation','livree','annulee'
  final DateTime createdAt;
  final String restaurantName;
  final String clientName;
  final List<OrderLine> items;

  Order({
    required this.id,
    required this.codeCommande,
    required this.restaurantCode,
    required this.clientCode,
    required this.totalCommande,
    required this.statutCommande,
    required this.createdAt,
    required this.restaurantName,
    required this.clientName,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codeCommande': codeCommande,
      'restaurantCode': restaurantCode,
      'clientCode': clientCode,
      'totalCommande': totalCommande,
      'statutCommande': statutCommande,
      'createdAt': createdAt.toIso8601String(),
      'restaurantName': restaurantName,
      'clientName': clientName,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      codeCommande: json['codeCommande'],
      restaurantCode: json['restaurantCode'],
      clientCode: json['clientCode'],
      totalCommande: json['totalCommande'],
      statutCommande: json['statutCommande'],
      createdAt: DateTime.parse(json['createdAt']),
      restaurantName: json['restaurantName'],
      clientName: json['clientName'],
      items: (json['items'] as List).map((item) => OrderLine.fromJson(item)).toList(),
    );
  }
}

class OrderLine {
  final int id;
  final String codeCommandeLigne;
  final String commandeCode;
  final String produitCode;
  final int quantite;
  final double prixUnitaire;
  final double totalLigne;
  final String productName;
  final String? productImage;

  OrderLine({
    required this.id,
    required this.codeCommandeLigne,
    required this.commandeCode,
    required this.produitCode,
    required this.quantite,
    required this.prixUnitaire,
    required this.totalLigne,
    required this.productName,
    this.productImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codeCommandeLigne': codeCommandeLigne,
      'commandeCode': commandeCode,
      'produitCode': produitCode,
      'quantite': quantite,
      'prixUnitaire': prixUnitaire,
      'totalLigne': totalLigne,
      'productName': productName,
      'productImage': productImage,
    };
  }

  factory OrderLine.fromJson(Map<String, dynamic> json) {
    return OrderLine(
      id: json['id'],
      codeCommandeLigne: json['codeCommandeLigne'],
      commandeCode: json['commandeCode'],
      produitCode: json['produitCode'],
      quantite: json['quantite'],
      prixUnitaire: json['prixUnitaire'],
      totalLigne: json['totalLigne'],
      productName: json['productName'],
      productImage: json['productImage'],
    );
  }
}