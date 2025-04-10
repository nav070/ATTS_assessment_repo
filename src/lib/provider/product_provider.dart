import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => List.unmodifiable(_products);

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(int index, Product updatedProduct) {
    if (index >= 0 && index < _products.length) {
      _products[index] = updatedProduct;
      notifyListeners();
    }
  }

  void deleteProduct(int index) {
    if (index >= 0 && index < _products.length) {
      _products.removeAt(index);
      notifyListeners();
    }
  }

  void clearAllProducts() {
    _products.clear();
    notifyListeners();
  }
}
