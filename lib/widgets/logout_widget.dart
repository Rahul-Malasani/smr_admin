import 'package:flutter/material.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
    if (shouldLogout == true) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => _confirmLogout(context),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Center(child: Text("Logout")), // ✅ label beside icon
        ),
      ],
    );
  }
}
