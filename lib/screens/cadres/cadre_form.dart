import 'package:flutter/material.dart';
import 'package:smr_admin/utils/validators.dart';

class CadreForm extends StatefulWidget {
  const CadreForm({super.key}); // 👈 add const constructor for consistency

  @override
  _CadreFormState createState() => _CadreFormState();
}

class _CadreFormState extends State<CadreForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(  // 👈 Now wrapped in Scaffold
      appBar: AppBar(
        title: const Text("Add / Edit Cadre"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Cadre Name"),
                validator: (value) =>
                    Validators.validateNameMinLength(value, 2),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("Cadre created: ${_nameController.text}");
                    // later call CadreService.add(...)
                    Navigator.pop(context, true); // ✅ return to list
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
