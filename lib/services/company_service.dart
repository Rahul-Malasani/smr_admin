import 'package:smr_admin/models/company.dart';

class CompanyService {
  static final List<Company> _companies = [
    Company(
      Cid: 1,
      name: "ABC Finance",
      openingDate: DateTime(2012, 5, 2),
      address: "Hyderabad",
      contact: "9876543210",
      logo: "assets/images/abc.png",
      noofBrs: 3,
      gprs: "2343", // make sure gprs is String in model
    ),
    Company(
      Cid: 2,
      name: "XYZ MicroLoans",
      openingDate: DateTime(2015, 8, 20),
      address: "Bangalore",
      contact: "9123456789",
      logo: "assets/images/xyz.png",
      noofBrs: 4,
      gprs: "21332",
    ),
  ];

  static List<Company> getAll() {
    return List<Company>.from(_companies);
  }
  static void add(Company company) {
    _companies.add(company);
  }

  static void update(int id, Company updatedCompany) {
    final index = _companies.indexWhere((c) => c.Cid == id);
    if (index != -1) {
      _companies[index] = updatedCompany;
    }
  }

  static void delete(int id) {
    _companies.removeWhere((c) => c.Cid == id);
  }
}
