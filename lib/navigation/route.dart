import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meditations_tracker/app/app_style.dart';
import 'package:meditations_tracker/navigation/page_transition.dart';

enum TransitionType { none, bottomUp, fadeIn }

class AppRoute<T> extends PageRoute<T> {
  final TransitionType transitionType;
  final AppStyle appStyle;
  final Widget widget;
  final bool dialog;
  @override
  final bool maintainState;
  @override
  final Color barrierColor;
  @override
  final String barrierLabel;

  AppRoute({
    @required this.widget,
    @required this.appStyle,
    @required RouteSettings settings,
    @required this.transitionType,
    this.barrierColor,
    this.barrierLabel,
    this.dialog = true,
    this.maintainState = true,
  }) : super(settings: settings);

  factory AppRoute.create({
    GetIt locator,
    Widget widget,
    RouteSettings settings,
    TransitionType transitionType,
    bool dialog = false,
  }) {
    return AppRoute(
      dialog: dialog,
      widget: widget,
      transitionType: transitionType,
      settings: settings,
      appStyle: locator(),
    );
  }

  @override
  bool get opaque => !dialog;

  @override
  bool get fullscreenDialog => dialog;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return widget;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (transitionType == TransitionType.none)
      return child;
    else if (transitionType == TransitionType.bottomUp) {
      return BottomUpPageTransition(child: child, animation: animation);
    } else {
      return FadeInTransitionPageTransition(child: child, animation: animation);
    }
  }

  @override
  Duration get transitionDuration => appStyle.pageTransitionDuration;

  @override
  String toString() {
    return 'MainRoute{widget: $widget, transitionType: $transitionType}';
  }
}
