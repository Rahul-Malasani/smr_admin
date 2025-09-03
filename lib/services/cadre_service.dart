import 'package:smr_admin/models/cadre.dart';

class CadreService {
  static final List<Cadre> _cadres = [
    Cadre(name: "Manager", createdDate: DateTime(2015, 1, 1)),
    Cadre(name: "Officer", createdDate: DateTime(2017, 3, 15)),
    Cadre(name: "Clerk", createdDate: DateTime(2019, 11, 20)),
  ];

  static List<Cadre> getAll() => List<Cadre>.from(_cadres);

  static void add(Cadre cadre) {
    _cadres.add(cadre);
  }

  static void delete(String name) {
    _cadres.removeWhere((c) => c.name == name);
  }

  static void update(String oldName, Cadre updated) {
    final index = _cadres.indexWhere((c) => c.name == oldName);
    if (index != -1) {
      _cadres[index] = updated;
    }
  }
}
