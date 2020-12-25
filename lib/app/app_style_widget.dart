import 'package:flutter/material.dart';
import 'package:meditations_tracker/app/app_style.dart';

class AppStyleWidget extends InheritedWidget {
  final AppStyle appStyle;

  const AppStyleWidget({
    @required this.appStyle,
    @required Widget child,
    Key key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AppStyleWidget oldWidget) =>
      appStyle == oldWidget.appStyle;

  static AppStyle of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppStyleWidget>().appStyle;
}
