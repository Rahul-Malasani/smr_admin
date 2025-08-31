import 'package:flutter/material.dart';
import 'package:smr_admin/services/company_service.dart';
import 'package:smr_admin/models/company.dart';

class CompanyListScreen extends StatelessWidget {
  const CompanyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Company> companies = CompanyService.getCompanies();

    return Scaffold(
      appBar: AppBar(title: const Text("Companies")),
      body: ListView.builder(
        itemCount: companies.length,
        itemBuilder: (context, index) {
          final company = companies[index];
          return ListTile(
            title: Text(company.name),
            subtitle: Text(company.address),
            trailing: Text(company.contact),
          );
        },
      ),
    );
  }
}
