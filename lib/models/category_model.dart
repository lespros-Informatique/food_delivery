class Category {
  int? idCategorie;
  String? codeCategorie;
  String? restaurantCode;
  String? nomCategorie;
  int? ordre;
  int? statut;

  Category({
    this.idCategorie,
    this.codeCategorie,
    this.restaurantCode,
    this.nomCategorie,
    this.ordre,
    this.statut,
  });

  Category.fromJson(Map<String, dynamic> json) {
    idCategorie = json['id_categorie'];
    codeCategorie = json['code_categorie'];
    restaurantCode = json['restaurant_code'];
    nomCategorie = json['nom_categorie'];
    ordre = json['ordre'];
    statut = json['statut'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id_categorie': idCategorie,
      'code_categorie': codeCategorie,
      'restaurant_code': restaurantCode,
      'nom_categorie': nomCategorie,
      'ordre': ordre,
      'statut': statut,
    };
  }
}