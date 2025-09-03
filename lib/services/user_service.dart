import 'package:smr_admin/models/user.dart';

class UserService {
  static final User _defaultAdmin = User(
    staffId: "SYSTEM_ADMIN",
    username: "admin",
    password: "Admin@@123",
    role: "Admin",
    isActive: true,
  );

  static final List<User> _users = [
    User(
      staffId: "EMP001",
      username: "John Doe",
      password: "Pass@@1234",
      createdAt: DateTime(2024, 1, 1),
      validUntil: DateTime(2025, 1, 1),
      isActive: true,
      role: "Admin",
    ),
    User(
      staffId: "EMP002",
      username: "Jane Smith",
      password: "Hello##99",
      createdAt: DateTime(2024, 3, 15),
      validUntil: DateTime(2025, 3, 15),
      isActive: false,
      role: "DataEntry",
    ),
  ];

  static List<User> getAll() {
    return List<User>.from([_defaultAdmin, ..._users]);
  }

  static void add(User user) {
    _users.add(user);
  }

  static void update(String staffId, User updatedUser) {
    final index = _users.indexWhere((u) => u.staffId == staffId);
    if (index != -1) {
      _users[index] = updatedUser;
    }
  }

  static void delete(String staffId) {
    if (staffId == "SYSTEM_ADMIN") return; // ❌ cannot delete default admin
    _users.removeWhere((u) => u.staffId == staffId);
  }
}
