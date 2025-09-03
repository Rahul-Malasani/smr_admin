import 'package:smr_admin/models/user.dart';
import 'package:smr_admin/services/user_service.dart';

class AuthService {
  /// Returns a Map with status and user if found.
  /// Example:
  /// {"status": "success", "user": user}
  /// {"status": "user_not_found"}
  /// {"status": "wrong_password"}
  static Map<String, dynamic> login(String username, String password) {
    final users = UserService.getAll();

    // Step 1: check if any user exists with username
    final matchingUsers =
        users.where((u) => u.username == username).toList();

    if (matchingUsers.isEmpty) {
      return {"status": "user_not_found"};
    }

    final user = matchingUsers.first;

    // Step 2: check password
    if (user.password != password) {
      return {"status": "wrong_password"};
    }

    // Success ✅
    return {"status": "success", "user": user};
  }
}
