class Restaurant {
  int? idRestaurant;
  String? codeRestaurant;
  String? nomRestaurant;
  String? description;
  String? adresse;
  String? ville;
  String? logo;
  int? statut;
  double? latitude;
  double? longitude;
  String? createdAt;
  String? updatedAt;

  Restaurant({
    this.idRestaurant,
    this.codeRestaurant,
    this.nomRestaurant,
    this.description,
    this.adresse,
    this.ville,
    this.logo,
    this.statut,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  Restaurant.fromJson(Map<String, dynamic> json) {
    idRestaurant = json['id_restaurant'];
    codeRestaurant = json['code_restaurant'];
    nomRestaurant = json['nom_restaurant'];
    description = json['description'];
    adresse = json['adresse'];
    ville = json['ville'];
    logo = json['logo'];
    statut = json['statut'];
    latitude = json['latitude']?.toDouble();
    longitude = json['longitude']?.toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id_restaurant': idRestaurant,
      'code_restaurant': codeRestaurant,
      'nom_restaurant': nomRestaurant,
      'description': description,
      'adresse': adresse,
      'ville': ville,
      'logo': logo,
      'statut': statut,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}