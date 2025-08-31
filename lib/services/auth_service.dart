import 'package:smr_admin/models/user.dart';

class AuthService {
  static final List<User> _users = [
    User(username: "admin", password: "admin123", role: "Admin"),
    User(username: "staff", password: "staff123", role: "Staff"),
    User(username: "reports", password: "reports123", role: "Reports"),
  ];

  static User? login(String username, String password) {
    try {
      return _users.firstWhere(
        (user) => user.username == username && user.password == password,
      );
    } catch (e) {
      return null;
    }
  }
}
