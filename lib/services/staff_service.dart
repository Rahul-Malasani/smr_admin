import '../models/staff.dart';

class StaffService {
  static List<Staff> getStaff(int branchId) {
    return [
      Staff(
        id: 1,
        branchId: 101,
        name: "Ravi Kumar",
        cadre: "Manager",
        doj: "2018-02-14",
        contact: "9876543210",
      ),
      Staff(
        id: 2,
        branchId: 102,
        name: "Anjali Sharma",
        cadre: "Officer",
        doj: "2020-06-10",
        contact: "9123456789",
      ),
      Staff(
        id: 3,
        branchId: 201,
        name: "Rohit Singh",
        cadre: "Manager",
        doj: "2019-01-05",
        contact: "9988776655",
      ),
    ].where((staff) => staff.branchId == branchId).toList();
  }
}
