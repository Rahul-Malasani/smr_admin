import 'package:flutter/material.dart';
import 'package:smr_admin/services/staff_service.dart';
import 'package:smr_admin/models/staff.dart';

class StaffListScreen extends StatelessWidget {
  const StaffListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // For demo: load staff of Branch 101
    List<Staff> staffList = StaffService.getStaff(101);

    return Scaffold(
      appBar: AppBar(title: const Text("Staff")),
      body: ListView.builder(
        itemCount: staffList.length,
        itemBuilder: (context, index) {
          final staff = staffList[index];
          return ListTile(
            title: Text(staff.name),
            subtitle: Text("${staff.cadre} - ${staff.contact}"),
            trailing: Text(staff.doj),
          );
        },
      ),
    );
  }
}
