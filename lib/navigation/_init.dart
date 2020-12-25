import 'package:get_it/get_it.dart';
import 'package:meditations_tracker/navigation/app_navigation_widget.dart';
import 'package:meditations_tracker/navigation/navigation_service.dart';
import 'package:meditations_tracker/navigation/route_factory.dart';

import 'navigation_stack.dart';

void initLocator(GetIt locator) {
  locator.registerLazySingleton(() => NavigationStack());
  locator.registerLazySingleton(() => createRouteFactory(locator));
  locator.registerLazySingleton(() => NavigationService.create(locator));
  locator.registerLazySingleton<AppNavigationWidgetBuilder>(
    () => createAppNavigationWidget(locator),
  );
}
