import 'package:get_it/get_it.dart';

class UserService {
  UserService();

  factory UserService.create(GetIt locator) {
    return UserService();
  }

  void logout() {
    throw 'not implemented';
  }
}
