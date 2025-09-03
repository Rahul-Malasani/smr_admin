import 'package:flutter/material.dart';
import 'package:smr_admin/models/user.dart';
import 'package:smr_admin/services/user_service.dart';
import 'package:smr_admin/screens/user/user_form.dart';
import 'package:smr_admin/widgets/logout_widget.dart'; // ✅ import reusable logout

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    users = UserService.getAll();
  }

  Future<void> _addUser() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => const UserForm()),
    );
    if (result == true) {
      setState(() {
        users = UserService.getAll();
      });
    }
  }

  Future<void> _editUser(User user) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => UserForm(user: user)),
    );
    if (result == true) {
      setState(() {
        users = UserService.getAll();
      });
    }
  }

  void _deleteUser(String staffId) {
    UserService.delete(staffId);
    setState(() {
      users = UserService.getAll();
    });
  }

  Future<void> _confirmDelete(BuildContext context, String staffId) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this user?"),
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
      _deleteUser(staffId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        actions: const [
          LogoutWidget(), // ✅ reusable logout
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (ctx, i) {
          final user = users[i];
          return ListTile(
            title: Text(user.username),
            subtitle: Text(
              "Staff: ${user.staffId} • ${user.role} - ${user.isActive ? "Active" : "Inactive"}",
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: () => _editUser(user),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDelete(context, user.staffId),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        child: const Icon(Icons.add),
      ),
    );
  }
}
