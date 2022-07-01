import 'package:flutter/material.dart';
import 'package:productos/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ProductModel product;

  ProductFormProvider(this.product);

  bool isValid() {
    return formKey.currentState?.validate() ?? false;
  }

  void setAvailable(value) {
    product.available = value;
    notifyListeners();
  }
}
