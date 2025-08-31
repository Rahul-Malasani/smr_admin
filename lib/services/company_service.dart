import '../models/company.dart';

class CompanyService {
  static List<Company> getCompanies() {
    return [
      Company(
        id: 1,
        name: "ABC Finance",
        openingDate: "2010-05-12",
        address: "Hyderabad",
        contact: "9876543210",
        logo: "assets/images/abc.png", // optional dummy logo
      ),
      Company(
        id: 2,
        name: "XYZ MicroLoans",
        openingDate: "2015-08-20",
        address: "Bangalore",
        contact: "9123456789",
        logo: "assets/images/xyz.png",
      ),
    ];
  }
}
