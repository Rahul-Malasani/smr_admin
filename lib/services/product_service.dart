import '../models/product.dart';

class ProductService {
  static List<Product> getProducts() {
    return [
      Product(id: 501, name: "Personal Loan", isActive: true),
      Product(id: 502, name: "Vehicle Loan", isActive: true),
      Product(id: 503, name: "Gold Loan", isActive: false),
    ];
  }
}
