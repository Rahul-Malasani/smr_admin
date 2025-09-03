import 'package:flutter/material.dart';
import 'package:smr_admin/utils/validators.dart';
import 'package:smr_admin/services/auth_service.dart';
import 'package:smr_admin/models/user.dart';
import 'package:smr_admin/widgets/password_toggle.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  void _attemptLogin() {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();

      final result = AuthService.login(username, password);

      if (result["status"] == "success") {
        final User user = result["user"];
        setState(() => _errorMessage = null);

        // ✅ Navigate to Dashboard
        Navigator.pushReplacementNamed(
          context,
          '/dashboard',
          arguments: {'user': user},
        );
      } else if (result["status"] == "user_not_found") {
        setState(() => _errorMessage = "User does not exist");
      } else if (result["status"] == "wrong_password") {
        setState(() => _errorMessage = "Incorrect password");
      } else {
        setState(() => _errorMessage = "Login failed, please try again");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
          const SizedBox(height: 20),
          if (_errorMessage != null)
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _attemptLogin,
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
