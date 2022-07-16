import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String clientLoginRoute = "/clientLogin";
  static const String demoRoute = "/demo";
}

class RouteGenerator {
  static const _initialRouteId = 'Initial';
  static final _currentNameNotifier = ValueNotifier<String>(_initialRouteId);

  /// Reactive version for [currentName].
  static ValueNotifier<String> get currentNameNotifier => _currentNameNotifier;

  /// The current route id. If the current route
  /// is reached in a way other than [Navigator.toNamed],
  /// this id is stale.
  static String get currentName => _currentNameNotifier.value;

  /// Callback for MaterialApp's onGenerateRoute.
  static Route<dynamic> getRoute(RouteSettings settings) {
    // Update currentName;
    _currentNameNotifier.value = settings.name ?? 'Error';

    // For debugging.
    // Comment for less clutter.
    log(
      settings.name.toString(),
      name: 'Route',
    );

    // Match.
    switch (settings.name) {
      // case Routes.splashRoute:
      //   return CupertinoPageRoute(builder: (_) => const SplashPage());
      // case Routes.demoRoute:
      //   return CupertinoPageRoute(
      //       builder: (_) => const SegmentedControlSample());
      default:
        // In case of no matching screen, show error view.
        _currentNameNotifier.value = 'Error';
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return CupertinoPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('No Route Found')),
      ),
    );
  }
}

class NavigatorManager {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  goBack() {
    return navigatorKey.currentState!.pop();
  }

  Future<dynamic> navigateAndFinish(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }
}
