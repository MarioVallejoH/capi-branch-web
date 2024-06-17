import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web/src/config/router/custom_router.dart';
import 'package:web/src/utils/utils.dart';

/// Perform non async navigation task
class Navigation {
  /// Go to Home
  static goHome(
    BuildContext context, {
    bool removeUntil = true,
  }) {
    String route = CustomAppRouter.home;

    if (removeUntil) {
      goTo(
        route,
        context,
        removeUntil: true,
      );
    } else {
      goTo(
        route,
        context,
        replacement: true,
      );
    }
  }

  /// Navigator.pop custom implementation
  static goBack(BuildContext context, {VoidCallback? callback}) {
    callback?.call();
    if (context.canPop()) {
      context.pop();
    }
  }

  ///
  static bool navigate() {
    return !(GlobalLocator.responsiveDesign.isScreenEnough());
  }

  /// Go to named route
  static goTo(
    String route,
    BuildContext context, {
    bool removeUntil = false,
    bool replacement = false,
    Map<String, dynamic> extra = const {},
  }) {
    Future.delayed(Duration.zero, () {
      if (removeUntil) {
        if (context.canPop()) {
          context.pop();
        }
        context.replace(
          route,
          // queryParameters: arguments,
          extra: extra,
        );
      } else if (replacement) {
        context.pushReplacementNamed(
          route,
          extra: extra,
        );
      } else {
        context.pushNamed(
          route,
          extra: extra,
        );
      }
    });
  }
}
