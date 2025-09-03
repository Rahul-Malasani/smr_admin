import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smr_admin/utils/validators.dart';
import 'package:smr_admin/models/user.dart';
import 'package:smr_admin/services/user_service.dart';
import 'package:smr_admin/widgets/password_toggle.dart';

class UserForm extends StatefulWidget {
  final User? user; // null = add, not null = edit

  const UserForm({super.key, this.user});

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  final _staffIdController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _validUntilController = TextEditingController();

  bool _isActive = true;
  String _selectedRole = "Admin";

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _staffIdController.text = widget.user!.staffId;
      _usernameController.text = widget.user!.username;
      _passwordController.text = widget.user!.password;
      _validUntilController.text =
          DateFormat("dd/MM/yyyy").format(widget.user!.validUntil);
      _isActive = widget.user!.isActive;
      _selectedRole = widget.user!.role;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? "Add User" : "Edit User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _staffIdController,
                decoration: const InputDecoration(labelText: "Staff ID"),
                validator: Validators.isNotEmpty,
              ),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "Username"),
                validator: Validators.validateUsername,
              ),
              PasswordToggle(
              controller: _passwordController,
              label: "Password",
               validator: Validators.validatePassword,
),

              TextFormField(
                controller: _validUntilController,
                decoration: const InputDecoration(
                    labelText: "Valid Until (dd/MM/yyyy)"),
                validator: Validators.validateFutureDate,
              ),
              Row(
                children: [
                  const Text("Active"),
                  Checkbox(
                    value: _isActive,
                    onChanged: (val) =>
                        setState(() => _isActive = val ?? true),
                  ),
                ],
              ),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: const InputDecoration(labelText: "Role"),
                items: const [
                  DropdownMenuItem(value: "Admin", child: Text("Admin")),
                  DropdownMenuItem(value: "DataEntry", child: Text("Data Entry")),
                  DropdownMenuItem(value: "Master", child: Text("Master")),
                  DropdownMenuItem(value: "Reports", child: Text("Reports")),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _selectedRole = val);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final user = User(
                        staffId: _staffIdController.text.trim(),
                        username: _usernameController.text.trim(),
                        password: _passwordController.text,
                        validUntil: DateFormat("dd/MM/yyyy")
                            .parseStrict(_validUntilController.text),
                        isActive: _isActive,
                        role: _selectedRole,
                      );

                      if (widget.user == null) {
                        UserService.add(user);
                      } else {
                        UserService.update(user.staffId, user);
                      }

                      Navigator.pop(context, true);
                    } catch (e) {
                      print("Error saving user: $e");
                    }
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
