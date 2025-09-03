import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smr_admin/models/branch_product.dart';
import 'package:smr_admin/services/branch_service.dart';
import 'package:smr_admin/services/product_service.dart';
import 'package:smr_admin/services/branch-product_service.dart';
import 'package:smr_admin/screens/branch-product/branch-product_form.dart';
import 'package:smr_admin/widgets/logout_widget.dart'; // ✅ Reusable logout

class BranchProductListScreen extends StatefulWidget {
  const BranchProductListScreen({super.key});

  @override
  State<BranchProductListScreen> createState() =>
      _BranchProductListScreenState();
}

class _BranchProductListScreenState extends State<BranchProductListScreen> {
  List<BranchProduct> mappings = [];

  @override
  void initState() {
    super.initState();
    mappings = BranchProductService.getAll();
  }

  void _addMapping() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => const BranchProductForm()),
    ).then((_) {
      setState(() {
        mappings = BranchProductService.getAll();
      });
    });
  }

  void _editMapping(BranchProduct bp) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => BranchProductForm(mapping: bp)),
    ).then((_) {
      setState(() {
        mappings = BranchProductService.getAll();
      });
    });
  }

  void _deleteMapping(BranchProduct bp) {
    BranchProductService.delete(bp.branchId, bp.productId);
    setState(() {
      mappings = BranchProductService.getAll();
    });
  }

  Future<void> _confirmDelete(BuildContext context, Function onConfirm) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this mapping?"),
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
      onConfirm();
    }
  }

  String _getBranchName(int id) {
    final branches = BranchService.getAll();
    return branches.firstWhere((b) => b.id == id).name;
  }

  String _getProductName(int id) {
    final products = ProductService.getAll();
    return products.firstWhere((p) => p.id == id).name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch - Product Mapping"),
        actions: const [
          LogoutWidget(), // ✅ Reusable logout
        ],
      ),
      body: ListView.builder(
        itemCount: mappings.length,
        itemBuilder: (ctx, i) {
          final bp = mappings[i];
          return ListTile(
            title: Text(
              "Branch: ${_getBranchName(bp.branchId)} - Product: ${_getProductName(bp.productId)}",
            ),
            subtitle: Text(
              "${bp.isActive ? "Active" : "Inactive"} • Created: ${DateFormat('dd/MM/yyyy').format(bp.createdDate)}",
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: () => _editMapping(bp),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      _confirmDelete(context, () => _deleteMapping(bp)),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMapping,
        child: const Icon(Icons.add),
      ),
    );
  }
}
