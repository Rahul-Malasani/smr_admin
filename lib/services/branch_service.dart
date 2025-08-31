import '../models/branch.dart';

class BranchService {
  static List<Branch> getBranches(int companyId) {
    return [
      Branch(
        id: 101,
        companyId: 1,
        name: "Hyderabad Main",
        address: "Ameerpet",
        gps: "17.385,78.486",
      ),
      Branch(
        id: 102,
        companyId: 1,
        name: "Secunderabad Branch",
        address: "MG Road",
        gps: "17.439,78.498",
      ),
      Branch(
        id: 201,
        companyId: 2,
        name: "Bangalore Main",
        address: "MG Road",
        gps: "12.971,77.594",
      ),
    ].where((branch) => branch.companyId == companyId).toList();
  }
}
