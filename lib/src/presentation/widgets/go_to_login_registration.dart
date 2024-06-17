import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web/src/config/router/custom_router.dart';
import 'package:web/src/utils/utils.dart';

/// Go to login widget, shown on registration's screen bottom.
class GoToLogin extends StatelessWidget {
  /// Widget constructor
  const GoToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return _GoTo(
      text1: 'Ya tienes una cuenta?',
      text2: 'Inicia sesión',
      onTap: () {
        Navigation.goTo(CustomAppRouter.login, context);
      },
    );
  }
}

/// Go to registration widget, shown on login's screen bottom.
class GoToRegistration extends StatelessWidget {
  /// Widget constructor
  const GoToRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return _GoTo(
      text1: 'No tienes una cuenta?',
      text2: 'Regístrate',
      onTap: () {
        if (context.canPop()) {
          context.pop();
        } else {
          context.pushReplacementNamed(
            CustomAppRouter.registration,
          );
        }
      },
    );
  }
}

/// Go to widget
class _GoTo extends StatelessWidget {
  /// Widget constructor
  const _GoTo({
    required this.onTap,
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyLarge;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: textStyle,
          ),
          TextSpan(
            text: ' $text2',
            style: textStyle?.copyWith(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
