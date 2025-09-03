import 'package:flutter/material.dart';
import 'package:smr_admin/models/user.dart';
import 'package:smr_admin/widgets/logout_widget.dart'; // ✅ Import reusable logout widget

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the user object passed from login
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final User user = args['user'];

    // Define menu options based on role (kept same as before)
    List<Map<String, String>> menuOptions = [];

    switch (user.role) {
      case "Admin":
        menuOptions = [
          {"title": "Companies", "route": "/companies"},
          {"title": "Branches", "route": "/branches"},
          {"title": "Staff", "route": "/staff"},
          {"title": "Products", "route": "/products"},
          {"title": "Cadres", "route": "/cadres"},
          {"title": "Users", "route": "/users"},
          {"title": "Branch-Product Mapping", "route": "/branch-products"},
        ];
        break;

      case "DataEntry":
        menuOptions = [
          {"title": "My Branch", "route": "/branches"},
          {"title": "Products", "route": "/products"},
        ];
        break;

      case "Reports":
        menuOptions = [
          {"title": "Reports", "route": "/reports"},
        ];
        break;

      case "Master":
        menuOptions = [
          {"title": "All Data", "route": "/all"},
          {"title": "Companies", "route": "/companies"},
          {"title": "Branches", "route": "/branches"},
          {"title": "Staff", "route": "/staff"},
          {"title": "Products", "route": "/products"},
          {"title": "Cadres", "route": "/cadres"},
          {"title": "Reports", "route": "/reports"},
        ];
        break;

      default:
        menuOptions = [
          {"title": "No Access", "route": "/"},
        ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard - ${user.role}"),
        actions: const [
          LogoutWidget(), // ✅ Reusable logout widget
        ],
      ),
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
