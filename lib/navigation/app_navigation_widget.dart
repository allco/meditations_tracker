import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meditations_tracker/common/enum_utils.dart';
import 'package:meditations_tracker/navigation/navigation_service.dart';
import 'package:meditations_tracker/navigation/navigation_stack.dart';
import 'package:meditations_tracker/navigation/route_factory.dart';

typedef AppNavigationWidgetBuilder = AppNavigationWidget Function(
    RouteDestination);

AppNavigationWidgetBuilder createAppNavigationWidget(GetIt locator) =>
    (RouteDestination initialRoute) =>
        AppNavigationWidget.create(locator, initialRoute);

class AppNavigationWidget extends StatelessWidget {
  final AppRouteFactory routeFactory;
  final NavigationService routingService;
  final NavigationStack navigationStack;
  final RouteDestination initialRoute;

  const AppNavigationWidget(
    this.routeFactory,
    this.routingService,
    this.navigationStack, {
    Key key,
    this.initialRoute,
  }) : super(key: key);

  factory AppNavigationWidget.create(
      GetIt locator, RouteDestination initialRoute) {
    return AppNavigationWidget(
      locator(),
      locator(),
      locator(),
      initialRoute: initialRoute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: routingService.key,
      initialRoute: enumAsString(initialRoute),
      onGenerateRoute: routeFactory,
      observers: [navigationStack],
    );
  }
}
