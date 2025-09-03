import 'package:flutter/material.dart';
import 'package:smr_admin/models/product.dart';
import 'package:smr_admin/services/product_service.dart';
import 'package:smr_admin/screens/products/product_form.dart';
import 'package:smr_admin/widgets/logout_widget.dart'; // ✅ import reusable logout

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    products = ProductService.getAll();
  }

  Future<void> _openForm({Product? product}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => ProductForm(product: product),
      ),
    );

    if (result == true) {
      setState(() {
        products = ProductService.getAll();
      });
    }
  }

  void _deleteProduct(int id) {
    ProductService.delete(id);
    setState(() {
      products = ProductService.getAll();
    });
  }

  Future<void> _confirmDelete(BuildContext context, int id) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this product?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      _deleteProduct(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: const [
          LogoutWidget(), // ✅ reusable logout
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, i) {
          final product = products[i];
          return ListTile(
            title: Text(product.name),
            subtitle: Text(product.isActive ? "Active" : "Inactive"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: () => _openForm(product: product),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      _confirmDelete(context, product.id), // ✅ confirmation
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
