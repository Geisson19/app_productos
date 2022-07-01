import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:productos/env.dart';
import 'package:productos/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final List<ProductModel> products = [];

  late ProductModel selectedProduct;

  final _sStorage = const FlutterSecureStorage();

  File? newImage;

  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    loadProducts();
  }

  Future loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(Env.baseUrlProductos, "products.json", {
      'auth': await _sStorage.read(key: "uToken"),
    });
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
      _updateProduct(product);
    } else {
      _createProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  void _updateProduct(ProductModel product) async {
    final url = Uri.https(Env.baseUrlProductos, "products/${product.id}.json", {
      'auth': await _sStorage.read(key: "uToken"),
    });
    final response = await http.put(url, body: product.toJson());

    if (response.statusCode == 200) {
      final index = products.indexWhere((p) => p.id == product.id);
      products[index] = product;
    }
    notifyListeners();
  }

  void _createProduct(ProductModel product) async {
    final url = Uri.https(Env.baseUrlProductos, "products.json", {
      'auth': await _sStorage.read(key: "uToken"),
    });
    final response = await http.post(url, body: product.toJson());
    final Map<String, dynamic> productMap = json.decode(response.body);
    product.id = productMap["name"];
    products.add(product);
    notifyListeners();
  }

  // Preview imagen del producto
  void updateSelectedProductImage(String imagePath) {
    newImage = File.fromUri(Uri.parse(imagePath));
    selectedProduct.picture = imagePath;
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newImage == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse(Env.cloudifyUrl);

    final imageUploadRequest = http.MultipartRequest("POST", url);
    final file = await http.MultipartFile.fromPath("file", newImage!.path);
    imageUploadRequest.files.add(file);

    final http.StreamedResponse streamResponse =
        await imageUploadRequest.send();

    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      isSaving = false;
      notifyListeners();
      return null;
    }

    newImage = null;
    final responseData = json.decode(response.body);

    isSaving = false;
    notifyListeners();
    return responseData["secure_url"];
  }
}
