import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:meditations_tracker/app/app_initializer.dart';
import 'package:meditations_tracker/app/app_style.dart';
import 'package:meditations_tracker/app/app_style_widget.dart';
import 'package:meditations_tracker/app/splash_screen_widget.dart';
import 'package:meditations_tracker/common/localization/app_localization.dart';
import 'package:meditations_tracker/navigation/app_navigation_widget.dart';
import 'package:meditations_tracker/navigation/route_factory.dart';

class AppWidget extends StatelessWidget {
  final AppStyle appStyle;
  final AppAsyncInitializer asyncInitializer;
  final LocaleResolutionCallback localeResolutionCallback;
  final AppNavigationWidgetBuilder navigationWidgetBuilder;
  final List<LocalizationsDelegate> localizationDelegates;

  const AppWidget(
    this.appStyle,
    this.asyncInitializer,
    this.localeResolutionCallback,
    this.navigationWidgetBuilder,
    this.localizationDelegates,
  );

  factory AppWidget.create(GetIt locator) {
    return AppWidget(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: getSupportedLocales(),
      localizationsDelegates: localizationDelegates,
      localeResolutionCallback: localeResolutionCallback,
      onGenerateTitle: (context) => getApplicationTitle(context),
      home: FutureBuilder(
        future: asyncInitializer(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return SplashScreenWidget();
          } else {
            return LayoutBuilder(
              builder: (context, _) {
                return AppStyleWidget(
                  appStyle: appStyle,
                  child: navigationWidgetBuilder(RouteDestination.mainPage),
                );
              },
            );
          }
        },
      ),
    );
  }

  String getApplicationTitle(BuildContext context) {
    return AppLocalization.of(context).translate('app_name');
  }
}
