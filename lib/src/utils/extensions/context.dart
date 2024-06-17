import 'package:flutter/material.dart';

/// Context extension to add some functionalities
extension ContextExtensions on BuildContext {
  /// Check if current user is mounted
  bool get mounted {
    try {
      widget;
      return true;
    } catch (e) {
      return false;
    }
  }
}
