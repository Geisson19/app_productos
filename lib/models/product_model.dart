// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'dart:convert';

class ProductModel {
  ProductModel({
    required this.available,
    required this.name,
    required this.price,
    this.picture,
  });

  bool available;
  String name;
  double price;
  String? picture;
  String? id;

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
      };
}
