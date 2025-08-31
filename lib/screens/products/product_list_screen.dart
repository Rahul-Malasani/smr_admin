import 'package:flutter/material.dart';
import 'package:smr_admin/services/product_service.dart';
import 'package:smr_admin/models/product.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> products = ProductService.getProducts();

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            trailing: Icon(
              product.isActive ? Icons.check_circle : Icons.cancel,
              color: product.isActive ? Colors.green : Colors.red,
            ),
          );
        },
      ),
    );
  }
}
