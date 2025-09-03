import 'package:smr_admin/models/branch.dart';

class BranchService {
  static final List<Branch> _branches = [
    Branch(
      id: 1,
      companyId: 100,
      name: "Head Office",
      address: "Main Street, Hyderabad",
      gprs: "17.3850, 78.4867",
      openingDate: DateTime(2020, 1, 1),  // ✅ Year, Month, Day
      contact: "9876543210",
      closingDate: DateTime(2099, 12, 31),
    ),
    Branch(
      id: 2,
      companyId: 100,
      name: "Branch B",
      address: "Secunderabad",
      gprs: "17.4399, 78.4983",
      openingDate: DateTime(2020, 5, 1),  // ✅ 1st May 2020
      contact: "9123456789",
      closingDate: DateTime(2099, 12, 31),
    ),
  ];

  static List<Branch> getAll() {
    return List<Branch>.from(_branches);
  }

  static List<Branch> getByCompany(int companyId) {
    return _branches.where((b) => b.companyId == companyId).toList();
  }

  static void add(Branch branch) {
    _branches.add(branch);
  }

  static void update(int id, Branch updatedBranch) {
    final index = _branches.indexWhere((b) => b.id == id);
    if (index != -1) {
      _branches[index] = updatedBranch;
    }
  }

  static void delete(int id) {
    _branches.removeWhere((b) => b.id == id);
  }
}
