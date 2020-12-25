import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meditations_tracker/common/enum_utils.dart';
import 'package:meditations_tracker/home/HomePageWidget.dart';
import 'package:meditations_tracker/navigation/route.dart';

enum RouteDestination {
  mainPage,
}

typedef AppRouteFactory = Route<dynamic> Function(RouteSettings settings);

AppRouteFactory createRouteFactory(GetIt locator) => (RouteSettings settings) {
      final destination =
          enumFromString(RouteDestination.values, settings.name);
      switch (destination) {
        case RouteDestination.mainPage:
          return AppRoute.create(
            locator: locator,
            settings: settings,
            widget: const HomePageWidget(),
            transitionType: TransitionType.fadeIn,
          );
          break;
      }
      throw 'AppRouteFactory. No route defined for ${settings.name}';
    };
