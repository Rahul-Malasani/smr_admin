import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smr_admin/models/branch.dart';
import 'package:smr_admin/services/branch_service.dart';
import 'package:smr_admin/utils/validators.dart';

class BranchForm extends StatefulWidget {
  final Branch? branch; // null → Add, not null → Edit

  const BranchForm({super.key, this.branch});

  @override
  State<BranchForm> createState() => _BranchFormState();
}

class _BranchFormState extends State<BranchForm> {
  final _formKey = GlobalKey<FormState>();

  final _companyIdController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _gprsController = TextEditingController();
  final _openingDateController = TextEditingController();
  final _contactController = TextEditingController();
  final _closingDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.branch != null) {
      _companyIdController.text = widget.branch!.companyId.toString();
      _nameController.text = widget.branch!.name;
      _addressController.text = widget.branch!.address;
      _gprsController.text = widget.branch!.gprs;
      _openingDateController.text =
          DateFormat("dd/MM/yyyy").format(widget.branch!.openingDate);
      _contactController.text = widget.branch!.contact;
      _closingDateController.text =
          DateFormat("dd/MM/yyyy").format(widget.branch!.closingDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.branch == null ? "Add Branch" : "Edit Branch")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _companyIdController,
                decoration: const InputDecoration(labelText: "Company ID"),
                validator: (v) => Validators.validateAlphanumericMinLength(v, 1),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Branch Name"),
                validator: (v) => Validators.validateNameMinLength(v, 4),
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: "Address"),
                validator: Validators.isNotEmpty,
              ),
              TextFormField(
                controller: _gprsController,
                decoration: const InputDecoration(labelText: "GPRS"),
                validator: Validators.isNotEmpty,
              ),
              TextFormField(
                controller: _openingDateController,
                decoration: const InputDecoration(labelText: "Opening Date (dd/MM/yyyy)"),
                validator: Validators.validatePastDate,
              ),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(labelText: "Contact Number"),
                keyboardType: TextInputType.phone,
                validator: Validators.isValidIndianPhone, //  Updated validator
              ),
              TextFormField(
                controller: _closingDateController,
                decoration: const InputDecoration(labelText: "Closing Date (dd/MM/yyyy)"),
                validator: Validators.validateFutureDate,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String contactInput = _contactController.text.trim();

                    // ✅ Auto prepend +91 if only 10 digits entered
                    if (RegExp(r'^\d{10}$').hasMatch(contactInput)) {
                      contactInput = "+91$contactInput";
                    }

                    final branch = Branch(
                      id: widget.branch?.id ?? DateTime.now().millisecondsSinceEpoch,
                      companyId: int.tryParse(_companyIdController.text) ?? 0,
                      name: _nameController.text.trim(),
                      address: _addressController.text.trim(),
                      gprs: _gprsController.text.trim(),
                      openingDate: DateFormat("dd/MM/yyyy")
                          .parseStrict(_openingDateController.text),
                      contact: contactInput, // ✅ Always saved with +91
                      closingDate: DateFormat("dd/MM/yyyy")
                          .parseStrict(_closingDateController.text),
                    );

                    if (widget.branch == null) {
                      BranchService.add(branch);
                    } else {
                      BranchService.update(widget.branch!.id, branch);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.branch == null ? "Save" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
