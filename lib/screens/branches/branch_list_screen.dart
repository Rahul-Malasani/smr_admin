import 'package:flutter/material.dart';
import 'package:smr_admin/services/branch_service.dart';
import 'package:smr_admin/models/branch.dart';

class BranchListScreen extends StatelessWidget {
  const BranchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // For demo: load branches of Company 1
    List<Branch> branches = BranchService.getBranches(1);

    return Scaffold(
      appBar: AppBar(title: const Text("Branches")),
      body: ListView.builder(
        itemCount: branches.length,
        itemBuilder: (context, index) {
          final branch = branches[index];
          return ListTile(
            title: Text(branch.name),
            subtitle: Text(branch.address),
            trailing: Text(branch.gps),
          );
        },
      ),
    );
  }
}
