import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web/src/presentation/views/views.dart';

/// A custom implementation of GoRouter that uses a [navKey].
class CustomAppRouter {
  /// Creates a CustomAppRouter with the specified [navKey].
  CustomAppRouter({required this.navKey});

  /// The navigator key used for routing.
  final GlobalKey<NavigatorState> navKey;

  // Route paths
  /// Represents the route path for the login screen.
  static const String login = '/login';
  // Route paths
  /// Represents the route path for the home screen.
  static const String home = '/home';

  /// Represents the route path for the registration screen.
  static const String registration = '/registration';

  /// Creates a GoRouter instance with defined routes and their corresponding builders.
  GoRouter get appRouter => GoRouter(
        navigatorKey: navKey,
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            name: '/',
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: login,
            name: login,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: registration,
            name: registration,
            builder: (context, state) => const RegistrationScreen(),
          ),
        ],
      );
}
