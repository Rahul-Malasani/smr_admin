import 'package:flutter/material.dart';
import 'package:smr_admin/models/user.dart';
import 'package:smr_admin/services/auth_service.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  void _login() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    User? user = AuthService.login(username, password);

    

    if (user != null) {
      setState(() => _errorMessage = null);

      // Navigate to Dashboard and pass user role
      Navigator.pushReplacementNamed(context, '/dashboard',
          arguments: {'user': user});
    } else {
      setState(() => _errorMessage = "Invalid username or password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("SMR Admin Login",
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 30),

              // Username Field
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "Username"),
              ),

              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),

              const SizedBox(height: 20),

              // Error Message
              if (_errorMessage != null)
                Text(_errorMessage!,
                    style: const TextStyle(color: Colors.red)),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _login,
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
