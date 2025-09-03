class Branch {
  final int id;
  final int companyId;
  final String name;
  final String address;
  final String gprs;          // or gprs in some files
  final DateTime openingDate;  // 👈 required
  final String contact;      // 👈 required
  final DateTime closingDate;  // 👈 required

  Branch({
    required this.id,
    required this.companyId,
    required this.name,
    required this.address,
    required this.gprs,
    required this.openingDate,
    required this.contact,
    required this.closingDate,
  });
}
