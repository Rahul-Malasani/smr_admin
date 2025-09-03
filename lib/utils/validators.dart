import 'package:intl/intl.dart';

class Validators {
  // ----------------- Auth -----------------
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Username is required";
    }
    final regex = RegExp(r'^[A-Za-z ]{3,}$'); // letters + spaces
    if (!regex.hasMatch(value.trim())) {
      return "Enter valid username (letters and spaces allowed)";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 6) return _passwordError;

    final digitCount = RegExp(r'\d').allMatches(value).length;
    final specialCount = RegExp(
      r'[!@#\$%^&*(),.?":{}|<>]',
    ).allMatches(value).length;
    final alphaCount = RegExp(r'[A-Za-z]').allMatches(value).length;
    final hasUpper = RegExp(r'[A-Z]').hasMatch(value);

    if (digitCount < 2 || specialCount < 2 || alphaCount < 4 || !hasUpper) {
      return _passwordError;
    }
    return null;
  }

  static const String _passwordError =
      "Enter strong password with minimum 6 characters "
      "and include atleast 2 numbers(1,2,3..) , "
      "2 special characters(@,*..) and "
      "4 alphabets(a,b..) with atleast one capital letter in it";

  // ----------------- Common -----------------
  static String? isNotEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }
    return null;
  }

  // ✅ shared date format validator
  static bool _isValidDateFormat(String value) {
    final regex = RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/[1-9][0-9]{3}$');
    if (!regex.hasMatch(value)) return false;

    try {
      DateFormat("dd/MM/yyyy").parseStrict(value);
      return true;
    } catch (_) {
      return false;
    }
  }

  static String? validatePastDate(String? value) {
    if (value == null || value.isEmpty) return "Date is required";
    if (!_isValidDateFormat(value)) return "Enter date in dd/MM/yyyy format";

    try {
      final parsed = DateFormat("dd/MM/yyyy").parseStrict(value);
      if (parsed.isAfter(DateTime.now())) {
        return "Date must be today or in the past";
      }
      return null;
    } catch (_) {
      return "Invalid date";
    }
  }

  static String? validateFutureDate(String? value) {
    if (value == null || value.isEmpty) return "Date is required";
    if (!_isValidDateFormat(value)) return "Enter date in dd/MM/yyyy format";

    try {
      final parsed = DateFormat("dd/MM/yyyy").parseStrict(value);
      if (parsed.isBefore(DateTime.now())) {
        return "Date must be in the future";
      }
      return null;
    } catch (_) {
      return "Invalid date";
    }
  }

  // ----------------- Branch -----------------
  static String? validateAlphanumericMinLength(String? value, int minLength) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }
    final regex = RegExp(r'^[a-zA-Z0-9]+$');
    if (!regex.hasMatch(value) || value.length < minLength) {
      return "Must be alphanumeric and at least $minLength characters";
    }
    return null;
  }

  static String? validateNameMinLength(String? value, int minLength) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    final regex = RegExp(r'^[a-zA-Z ]+$');
    if (!regex.hasMatch(value) || value.length < minLength) {
      return "Name must be at least $minLength letters (alphabets only)";
    }
    return null;
  }

  // ----------------- Phone -----------------
  static String? isValidIndianPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }

    String input = value.trim();

    // ✅ Auto prepend +91 if exactly 10 digits
    if (RegExp(r'^\d{10}$').hasMatch(input)) {
      input = "+91$input";
    }

    // ✅ Must strictly be +91 followed by 10 digits
    final regex = RegExp(r'^\+91\d{10}$');
    if (!regex.hasMatch(input)) {
      return "Enter valid phone (10 digits, auto +91 added)";
    }

    return null;
  }

  // ----------------- Others -----------------
  static String? isValidExperience(String? value) {
    if (value == null || value.isEmpty) {
      return "Experience is required";
    }
    final exp = int.tryParse(value);
    if (exp == null || exp < 0) {
      return "Enter a valid experience (0 or more years)";
    }
    return null;
  }

  static String? isValidNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }
    if (int.tryParse(value) == null) {
      return "Enter a valid number";
    }
    return null;
  }
}
