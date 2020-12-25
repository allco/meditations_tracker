import 'package:get_it/get_it.dart';
import 'package:meditations_tracker/service/UserService.dart';

void initLocator(GetIt locator) {
  locator.registerLazySingleton(() => UserService.create(locator));
}
