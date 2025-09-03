import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smr_admin/utils/validators.dart';
import 'package:smr_admin/models/staff.dart';
import 'package:smr_admin/services/staff_service.dart';

class StaffForm extends StatefulWidget {
  final Staff? staff; // null → Add, not null → Edit

  const StaffForm({super.key, this.staff});

  @override
  _StaffFormState createState() => _StaffFormState();
}

class _StaffFormState extends State<StaffForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _cadreController = TextEditingController();
  final _dojController = TextEditingController();
  final _contact1Controller = TextEditingController();
  final _contact2Controller = TextEditingController();
  final _parentsAddressController = TextEditingController();
  final _experienceController = TextEditingController();
  final _dobController = TextEditingController();
  final _qualificationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.staff != null) {
      _nameController.text = widget.staff!.name;
      _cadreController.text = widget.staff!.cadre;
      _dojController.text =
          DateFormat("dd/MM/yyyy").format(widget.staff!.doj);
      _contact1Controller.text = widget.staff!.contact1;
      _contact2Controller.text = widget.staff!.contact2 ?? '';
      _parentsAddressController.text = widget.staff!.parentsAddress;
      _experienceController.text = widget.staff!.experience.toString();
      _dobController.text =
          DateFormat("dd/MM/yyyy").format(widget.staff!.dob);
      _qualificationController.text = widget.staff!.qualification;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.staff == null ? "Add Staff" : "Edit Staff"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (v) => Validators.validateNameMinLength(v, 3),
              ),
              TextFormField(
                controller: _cadreController,
                decoration: const InputDecoration(labelText: "Cadre"),
                validator: Validators.isNotEmpty,
              ),
              TextFormField(
                controller: _dojController,
                decoration: const InputDecoration(
                    labelText: "Date of Joining (dd/MM/yyyy)"),
                validator: Validators.validatePastDate,
              ),
              TextFormField(
                controller: _contact1Controller,
                decoration: const InputDecoration(labelText: "Primary Contact"),
                keyboardType: TextInputType.phone,
                validator: Validators.isValidIndianPhone, // ✅ stricter validator
              ),
              TextFormField(
                controller: _contact2Controller,
                decoration: const InputDecoration(labelText: "Secondary Contact"),
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    v == null || v.isEmpty ? null : Validators.isValidIndianPhone(v),
              ),
              TextFormField(
                controller: _parentsAddressController,
                decoration: const InputDecoration(labelText: "Parents Address"),
                validator: Validators.isNotEmpty,
              ),
              TextFormField(
                controller: _experienceController,
                decoration:
                    const InputDecoration(labelText: "Experience (years)"),
                validator: Validators.isValidExperience,
              ),
              TextFormField(
                controller: _dobController,
                decoration:
                    const InputDecoration(labelText: "Date of Birth (dd/MM/yyyy)"),
                validator: Validators.validatePastDate,
              ),
              TextFormField(
                controller: _qualificationController,
                decoration: const InputDecoration(labelText: "Qualification"),
                validator: Validators.isNotEmpty,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    try {
                      // ✅ Auto-prepend +91 if only 10 digits entered
                      String contact1 = _contact1Controller.text.trim();
                      if (RegExp(r'^\d{10}$').hasMatch(contact1)) {
                        contact1 = "+91$contact1";
                      }

                      String? contact2 =
                          _contact2Controller.text.trim().isEmpty
                              ? null
                              : _contact2Controller.text.trim();
                      if (contact2 != null &&
                          RegExp(r'^\d{10}$').hasMatch(contact2)) {
                        contact2 = "+91$contact2";
                      }

                      final staff = Staff(
                        id: widget.staff?.id ??
                            DateTime.now().millisecondsSinceEpoch,
                        branchId: widget.staff?.branchId ??
                            101, // dummy; later link to branch
                        name: _nameController.text.trim(),
                        cadre: _cadreController.text.trim(),
                        doj: DateFormat("dd/MM/yyyy")
                            .parseStrict(_dojController.text),
                        contact1: contact1,
                        contact2: contact2,
                        parentsAddress: _parentsAddressController.text.trim(),
                        experience:
                            int.tryParse(_experienceController.text) ?? 0,
                        dob: DateFormat("dd/MM/yyyy")
                            .parseStrict(_dobController.text),
                        qualification: _qualificationController.text.trim(),
                      );

                      if (widget.staff == null) {
                        StaffService.add(staff);
                      } else {
                        StaffService.update(widget.staff!.id, staff);
                      }

                      Navigator.pop(context);
                    } catch (e) {
                      print("Error saving staff: $e");
                    }
                  }
                },
                child: Text(widget.staff == null ? "Save" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
