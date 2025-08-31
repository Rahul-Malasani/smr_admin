import 'package:flutter/material.dart';
import 'package:smr_admin/models/user.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the user object passed from login
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final User user = args['user'];

    // Define menu options based on role
    List<Map<String, String>> menuOptions = [];

    if (user.role == "Admin") {
      menuOptions = [
        {"title": "Companies", "route": "/companies"},
        {"title": "Branches", "route": "/branches"},
        {"title": "Staff", "route": "/staff"},
        {"title": "Products", "route": "/products"},
        {"title": "Cadres", "route": "/cadres"},
      ];
    } else if (user.role == "Staff") {
      menuOptions = [
        {"title": "My Branch", "route": "/branches"},
        {"title": "Products", "route": "/products"},
      ];
    } else if (user.role == "Reports") {
      menuOptions = [
        {"title": "Reports", "route": "/reports"},
      ];
    }

    return Scaffold(
      appBar: AppBar(title: Text("Dashboard - ${user.role}")),
      body: ListView.builder(
        itemCount: menuOptions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(menuOptions[index]["title"]!),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, menuOptions[index]["route"]!);
            },
          );
        },
      ),
    );
  }
}
