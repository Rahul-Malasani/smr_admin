import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smr_admin/models/company.dart';
import 'package:smr_admin/services/company_service.dart';
import 'package:smr_admin/screens/companies/company_form.dart';
import 'package:smr_admin/widgets/logout_widget.dart'; // ✅ import reusable logout

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({super.key});

  @override
  State<CompanyListScreen> createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  List<Company> companies = [];

  @override
  void initState() {
    super.initState();
    companies = CompanyService.getAll();
  }

  void _addCompany() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => const CompanyForm()),
    ).then((_) {
      setState(() {
        companies = CompanyService.getAll();
      });
    });
  }

  void _editCompany(Company company) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => CompanyForm(company: company)),
    ).then((_) {
      setState(() {
        companies = CompanyService.getAll();
      });
    });
  }

  void _deleteCompany(Company company) {
    CompanyService.delete(company.Cid);
    setState(() {
      companies = CompanyService.getAll();
    });
  }

  Future<void> _confirmDelete(BuildContext context, Company company) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text("Are you sure you want to delete ${company.name}?"),
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
      _deleteCompany(company);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Companies"),
        actions: const [
          LogoutWidget(), // ✅ use global logout
        ],
      ),
      body: ListView.builder(
        itemCount: companies.length,
        itemBuilder: (context, index) {
          final company = companies[index];
          return ListTile(
            title: Text(company.name),
            subtitle: Text(
              "${company.address} • Opened: ${DateFormat('dd/MM/yyyy').format(company.openingDate)}",
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: () => _editCompany(company),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDelete(context, company),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCompany,
        child: const Icon(Icons.add),
      ),
    );
  }
}
