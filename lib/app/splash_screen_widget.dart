import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meditations_tracker/common/localization/app_localization.dart';

class SplashScreenWidget extends StatelessWidget {
  final locator = GetIt.I;

  SplashScreenWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalization.of(context);
    return Scaffold(
      body: Center(
        child: Text(
          locale('app_name'),
        ),
      ),
    );
  }
}
