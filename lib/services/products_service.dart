import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = "flutter-apps-286ec-default-rtdb.firebaseio.com";
  final List<ProductModel> products = [];

  bool isLoading = true;

  ProductsService() {
    loadProducts();
  }

  Future loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, "products.json");
    final response = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(response.body);

    productsMap.forEach((key, value) {
      final tempProduct = ProductModel.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();
  }
}
