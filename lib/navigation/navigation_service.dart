import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:meditations_tracker/logging/_init.dart';
import 'package:meditations_tracker/navigation/navigation_stack.dart';

/// Same as Activity.launchMode on Android
enum LaunchMode {
  singleTop, // only one instance on top of the stack (the stack can still contain other instances inside)
  singleTask, // only one instance per entire stack (e.g. Bidding)
  singleInstance, // clean entire stack and then add it on top (e.g. HomePage)
  noRestrictions, // no restrictions
}

class NavigationService {
  final key = GlobalKey<NavigatorState>();
  final NavigationStack stack;
  final Logger logger;

  NavigationService(this.logger, this.stack);

  factory NavigationService.create(GetIt locator) {
    return NavigationService(
      createLogger('log_navigation_service'),
      locator(),
    );
  }

  Future<bool> pop({@required bool force}) async {
    if (force) {
      key.currentState.pop();
      return true;
    } else
      return key.currentState.maybePop();
  }

  void _navigateTo(String routeName, LaunchMode launchMode) {
    logger?.fine('preparing stack for $routeName, $launchMode');

    switch (launchMode) {
      case LaunchMode.singleTop:
        key.currentState.popUntil((route) => route.settings.name != routeName);
        break;
      case LaunchMode.singleInstance:
        key.currentState.popUntil((route) => false);
        break;
      case LaunchMode.singleTask:
        if (stack.hasRoute(routeName)) {
          assert(key.currentState.canPop());
          key.currentState
              .popUntil((route) => route.settings.name == routeName);
          key.currentState
              .popUntil((route) => route.settings.name != routeName);
        }
        break;
      case LaunchMode.noRestrictions:
        break;
    }
    logger?.fine('push route $routeName');
    key.currentState.pushNamed(routeName);
  }
}
