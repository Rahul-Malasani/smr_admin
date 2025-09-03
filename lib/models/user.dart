class User {
  final String staffId;        // 👈 primary identifier (linked to Staff)
  final String username;
  final String password;
  final DateTime createdAt;
  final DateTime validUntil;
  final bool isActive;
  final String role; // "Admin", "DataEntry", "Master", "Reports"

  User({
    required this.staffId,
    required this.username,
    required this.password,
    DateTime? createdAt,
    DateTime? validUntil,
    this.isActive = true,
    required this.role,
  })  : createdAt = createdAt ?? DateTime.now(),
        validUntil = validUntil ?? DateTime.now().add(const Duration(days: 365));
}
