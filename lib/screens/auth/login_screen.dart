import 'package:flutter/material.dart';
import 'package:smr_admin/screens/auth/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SMR Admin Login",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 30),
              LoginForm(), // ✅ only form
            ],
          ),
        ),
      ),
    );
  }
}
