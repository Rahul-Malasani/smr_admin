import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smr_admin/models/company.dart';
import 'package:smr_admin/services/company_service.dart';
import 'package:smr_admin/utils/validators.dart';

class CompanyForm extends StatefulWidget {
  final Company? company; // null → Add, not null → Edit

  const CompanyForm({super.key, this.company});

  @override
  State<CompanyForm> createState() => _CompanyFormState();
}

class _CompanyFormState extends State<CompanyForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _openingDateController = TextEditingController();
  final _logoController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _gprsController = TextEditingController();
  final _branchesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.company != null) {
      _nameController.text = widget.company!.name;
      _openingDateController.text =
          DateFormat("dd/MM/yyyy").format(widget.company!.openingDate);
      _logoController.text = widget.company!.logo;
      _addressController.text = widget.company!.address;
      _contactController.text = widget.company!.contact;
      _gprsController.text = widget.company!.gprs;
      _branchesController.text = widget.company!.noofBrs.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.company == null ? "Add Company" : "Edit Company"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Company Name"),
                validator: (v) => Validators.validateNameMinLength(v, 4),
              ),
              TextFormField(
                controller: _openingDateController,
                decoration:
                    const InputDecoration(labelText: "Opening Date (dd/MM/yyyy)"),
                validator: Validators.validatePastDate,
              ),
              TextFormField(
                controller: _logoController,
                decoration: const InputDecoration(labelText: "Logo (URL/Path)"),
                validator: Validators.isNotEmpty,
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: "Address"),
                validator: Validators.isNotEmpty,
              ),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(labelText: "Contact Number"),
                keyboardType: TextInputType.phone,
                validator: Validators.isValidIndianPhone,
              ),
              TextFormField(
                controller: _gprsController,
                decoration: const InputDecoration(labelText: "GPRS"),
                validator: Validators.isNotEmpty,
              ),
              TextFormField(
                controller: _branchesController,
                decoration:
                    const InputDecoration(labelText: "Number of Branches"),
                keyboardType: TextInputType.number,
                validator: Validators.isValidNumber,
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

                    final company = Company(
                      Cid: widget.company?.Cid ??
                          DateTime.now().millisecondsSinceEpoch,
                      name: _nameController.text.trim(),
                      openingDate: DateFormat("dd/MM/yyyy")
                          .parseStrict(_openingDateController.text),
                      address: _addressController.text.trim(),
                      contact: contactInput, // ✅ Always stored with +91
                      logo: _logoController.text.trim(),
                      gprs: _gprsController.text.trim(),
                      noofBrs: int.parse(_branchesController.text),
                    );

                    if (widget.company == null) {
                      CompanyService.add(company);
                    } else {
                      CompanyService.update(widget.company!.Cid, company);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.company == null ? "Save" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
