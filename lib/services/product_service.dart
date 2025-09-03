import 'package:smr_admin/models/product.dart';

class ProductService {
  static final List<Product> _products = [
    Product(
      id: 1,
      name: "Gold Loan",
      isActive: true,
      createdDate: DateTime(2023, 6, 10),
    ),
    Product(
      id: 2,
      name: "Micro Credit",
      isActive: true,
      createdDate: DateTime(2024, 1, 15),
    ),
    Product(
      id: 3,
      name: "Savings Account",
      isActive: false,
      createdDate: DateTime(2022, 12, 1),
    ),
  ];

  static List<Product> getAll() => List<Product>.from(_products);

  static void add(Product product) {
    _products.add(product);
  }

  static void update(int id, Product updated) {
    final index = _products.indexWhere((p) => p.id == id);
    if (index != -1) {
      _products[index] = updated;
    }
  }

  static void delete(int id) {
    _products.removeWhere((p) => p.id == id);
  }
}
