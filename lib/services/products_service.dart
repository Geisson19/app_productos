import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = "???";
  final List<ProductModel> products = [];

  late ProductModel selectedProduct;

  bool isLoading = true;
  bool isSaving = false;

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

  Future createOrUpdate(ProductModel product) async {
    isSaving = true;
    notifyListeners();

    if (product.id != null) {
      await _updateProduct(product);
    } else {
      await _createProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  _updateProduct(ProductModel product) async {
    final url = Uri.https(_baseUrl, "products/${product.id}.json");
    final response = await http.put(url, body: product.toJson());

    if (response.statusCode == 200) {
      final index = products.indexWhere((p) => p.id == product.id);
      products[index] = product;
    }
  }

  _createProduct(ProductModel product) async {
    final url = Uri.https(_baseUrl, "products.json");
    final response = await http.post(url, body: product.toJson());
    final Map<String, dynamic> productMap = json.decode(response.body);
    product.id = productMap["name"];
    products.add(product);
  }
}
