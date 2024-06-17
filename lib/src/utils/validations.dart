/// App validation functions
class AppValidations {
  /// Validate if a string is a phone number with 10 len chars
  static String? validatePhone(String? phone) {
    if ((phone ?? '').isEmpty) return null;
    if (!isNumeric(phone) && (phone ?? '').length != 10) {
      return 'Número de teléfono no válido';
    }
    return null;
  }

  /// Check if string is numeric
  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  /// Validate if a given string contains at least 1 letter, 1 number and len 6-8.
  static String? validatePassword(
    String? password,
  ) {
    if (password?.isEmpty ?? true) {
      return 'Campo requerido';
    } else {
      bool hasMinLength = (password?.length ?? 0) >= 6;
      if (!hasMinLength) {
        // if (!hasMinLength) {
        return 'La longitud de la contraseña debe ser mayor a 6 caracteres';
      }
    }
    return null;
  }

  /// Checks if field is not empty
  static String? notEmptyFieldValidation(Object? value, {String? message}) {
    if (value is String?) {
      if (value == null || value.isEmpty) {
        return message ?? 'Campo requerido';
      }
      return null;
    }
    return null;
  }
}
