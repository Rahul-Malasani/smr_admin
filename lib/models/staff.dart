class Staff {
  final int id;
  final int branchId;
  final String name;
  final String cadre;
  final DateTime doj;
  final String contact1;
  final String? contact2; // nullable
  final String parentsAddress;
  final int experience;
  final DateTime dob;
  final String qualification;

  Staff({
    required this.id,
    required this.branchId,
    required this.name,
    required this.cadre,
    required this.doj,
    required this.contact1,
    this.contact2,
    required this.parentsAddress,
    required this.experience,
    required this.dob,
    required this.qualification,
  });
}
