import '../models/cadre.dart';

class CadreService {
  static List<Cadre> getCadres() {
    return [
      Cadre(id: 1, name: "Manager", createdDate: "2015-01-01"),
      Cadre(id: 2, name: "Officer", createdDate: "2017-03-15"),
      Cadre(id: 3, name: "Clerk", createdDate: "2019-11-20"),
    ];
  }
}
