import 'package:smr_admin/models/staff.dart';

class StaffService {
  static final List<Staff> _staff = [
    Staff(
      id: 1,
      branchId: 101,
      name: "Ravi Kumar",
      cadre: "Manager",
      doj: DateTime(2018, 2, 18),
      contact1: "9876543210",
      contact2: "9876500000",
      parentsAddress: "Hyderabad",           // ✅ mandatory field added
      experience: 6,
      dob: DateTime(1988, 5, 20),
      qualification: "MBA",
    ),
    Staff(
      id: 2,
      branchId: 102,
      name: "Anjali Sharma",
      cadre: "Officer",
      doj: DateTime(2020, 06, 20),
      contact1: "9123456789",
      parentsAddress: " Delhi",
      experience: 4,
      dob: DateTime(1990, 9, 14),
      qualification: "B.Com",
    ),
    Staff(
      id: 3,
      branchId: 201,
      name: "Rohit Singh",
      cadre: "Manager",
      doj: DateTime(2019, 1, 5),
      contact1: "9988776655",
      parentsAddress: " in Jaipur",
      experience: 5,
      dob: DateTime(1985, 2, 2),
      qualification: "CA",
    ),
  ];

  static List<Staff> getByBranch(int branchId) {
    return _staff.where((s) => s.branchId == branchId).toList();
  }

  static List<Staff> getAll() {
    return List<Staff>.from(_staff);
  }

  static void add(Staff staff) {
    _staff.add(staff);
  }

  static void update(int id, Staff updated) {
    final index = _staff.indexWhere((s) => s.id == id);
    if (index != -1) {
      _staff[index] = updated;
    }
  }

  static void delete(int id) {
    _staff.removeWhere((s) => s.id == id);
  }
}
