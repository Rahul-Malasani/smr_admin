import 'package:flutter/material.dart';

class PasswordToggle extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  const PasswordToggle({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
  });

  @override
  State<PasswordToggle> createState() => _PasswordToggleState();
}

class _PasswordToggleState extends State<PasswordToggle> {
  bool _obscure = true; // 👁️ starts hidden

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscure,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: IconButton(
          icon: Icon(
            _obscure ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
        ),
      ),
    );
  }
}
