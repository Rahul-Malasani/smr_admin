import 'package:flutter/material.dart';
import 'package:smr_admin/models/branch_product.dart';
import 'package:smr_admin/models/branch.dart';
import 'package:smr_admin/models/product.dart';
import 'package:smr_admin/services/branch_service.dart';
import 'package:smr_admin/services/product_service.dart';
import 'package:smr_admin/services/branch-product_service.dart';

class BranchProductForm extends StatefulWidget {
  final BranchProduct? mapping; // null → Add, not null → Edit

  const BranchProductForm({super.key, this.mapping});

  @override
  _BranchProductFormState createState() => _BranchProductFormState();
}

class _BranchProductFormState extends State<BranchProductForm> {
  final _formKey = GlobalKey<FormState>();

  Branch? _selectedBranch;
  Product? _selectedProduct;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    if (widget.mapping != null) {
      final branches = BranchService.getAll();
      final products = ProductService.getAll();

      _selectedBranch =
          branches.firstWhere((b) => b.id == widget.mapping!.branchId);
      _selectedProduct =
          products.firstWhere((p) => p.id == widget.mapping!.productId);
      _isActive = widget.mapping!.isActive;
    }
  }

  @override
  Widget build(BuildContext context) {
    final branches = BranchService.getAll();
    final products = ProductService.getAll();

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.mapping == null
              ? "Add Branch-Product Mapping"
              : "Edit Branch-Product Mapping")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<Branch>(
                value: _selectedBranch,
                items: branches
                    .map((b) => DropdownMenuItem(
                          value: b,
                          child: Text(b.name),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedBranch = val),
                decoration: const InputDecoration(labelText: "Select Branch"),
                validator: (val) =>
                    val == null ? "Branch is required" : null,
              ),
              DropdownButtonFormField<Product>(
                value: _selectedProduct,
                items: products
                    .map((p) => DropdownMenuItem(
                          value: p,
                          child: Text(p.name),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedProduct = val),
                decoration: const InputDecoration(labelText: "Select Product"),
                validator: (val) =>
                    val == null ? "Product is required" : null,
              ),
              Row(
                children: [
                  const Text("Active"),
                  Checkbox(
                    value: _isActive,
                    onChanged: (val) => setState(() => _isActive = val ?? true),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newMapping = BranchProduct(
                      branchId: _selectedBranch!.id,
                      productId: _selectedProduct!.id,
                      createdDate:
                          widget.mapping == null ? DateTime.now() : widget.mapping!.createdDate,
                      isActive: _isActive,
                    );

                    if (widget.mapping == null) {
                      BranchProductService.add(newMapping);
                    } else {
                      BranchProductService.update(
                          widget.mapping!.branchId,
                          widget.mapping!.productId,
                          newMapping);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.mapping == null ? "Save" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
