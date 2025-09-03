import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smr_admin/models/branch.dart';
import 'package:smr_admin/services/branch_service.dart';
import 'package:smr_admin/screens/branches/branch_form.dart';
import 'package:smr_admin/widgets/logout_widget.dart'; // ✅ Reusable logout

class BranchListScreen extends StatefulWidget {
  const BranchListScreen({super.key});

  @override
  State<BranchListScreen> createState() => _BranchListScreenState();
}

class _BranchListScreenState extends State<BranchListScreen> {
  List<Branch> branches = [];

  @override
  void initState() {
    super.initState();
    branches = BranchService.getAll();
  }

  void _addBranch() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => const BranchForm()),
    ).then((_) {
      setState(() {
        branches = BranchService.getAll();
      });
    });
  }

  void _editBranch(Branch branch) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => BranchForm(branch: branch)),
    ).then((_) {
      setState(() {
        branches = BranchService.getAll();
      });
    });
  }

  void _deleteBranch(Branch branch) {
    BranchService.delete(branch.id);
    setState(() {
      branches = BranchService.getAll();
    });
  }

  Future<void> _confirmDelete(BuildContext context, Function onConfirm) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this branch?"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branches"),
        actions: const [
          LogoutWidget(), // ✅ Reusable logout
        ],
      ),
      body: ListView.builder(
        itemCount: branches.length,
        itemBuilder: (context, index) {
          final branch = branches[index];
          return ListTile(
            title: Text(branch.name),
            subtitle: Text(
              "${branch.address} • Opened: ${DateFormat('dd/MM/yyyy').format(branch.openingDate)}",
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: () => _editBranch(branch),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      _confirmDelete(context, () => _deleteBranch(branch)),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBranch,
        child: const Icon(Icons.add),
      ),
    );
  }
}
