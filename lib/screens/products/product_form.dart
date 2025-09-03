import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smr_admin/utils/validators.dart';
import 'package:smr_admin/models/product.dart';
import 'package:smr_admin/services/product_service.dart';

class ProductForm extends StatefulWidget {
  final Product? product; // ✅ null = new, not null = edit

  const ProductForm({super.key, this.product});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _isActive = widget.product!.isActive;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? "Add Product" : "Edit Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Product Name"),
                validator: (value) => Validators.validateNameMinLength(value, 3),
              ),
              Row(
                children: [
                  const Text("Active"),
                  Checkbox(
                    value: _isActive,
                    onChanged: (val) {
                      setState(() => _isActive = val ?? true);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.product == null) {
                      // ✅ Add new product
                      final newProduct = Product(
                        id: DateTime.now().millisecondsSinceEpoch,
                        name: _nameController.text,
                        isActive: _isActive,
                        createdDate: DateTime.now(),
                      );
                      ProductService.add(newProduct);
                    } else {
                      // ✅ Update existing product
                      final updated = Product(
                        id: widget.product!.id,
                        name: _nameController.text,
                        isActive: _isActive,
                        createdDate: widget.product!.createdDate,
                      );
                      ProductService.update(widget.product!.id, updated);
                    }

                    Navigator.pop(context, true); // return flag to refresh
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
