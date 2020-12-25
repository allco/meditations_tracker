import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:meditations_tracker/logging/_init.dart';

// ignore: implementation_imports
//import 'package:wiredash/src/common/widgets/dismissible_page_route.dart';

class SafeStack<T> {
  final Logger logger;
  final List<T> _stack = [];

  SafeStack(this.logger);

  T getFirstOrNull() {
    return _stack.first;
  }

  void push(T element) {
    _stack.add(element);
    logger?.fine('after push $_stack');
  }

  void pop() {
    _stack.removeLast();
    logger?.fine('after pop $_stack');
  }

  bool contains(T element) {
    return _stack.contains(element);
  }
}

class NavigationStack extends NavigatorObserver {
  final _stack = SafeStack<String>(createLogger('log_navigation_stack'));

  String getTopRouteNameOrNull() {
    return _stack.getFirstOrNull();
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    _stack.push(getName(route));
  }

  String getName(Route route) {
    return route.settings?.name ?? '<no_name>';
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    _stack.pop();
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    _stack.pop();
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    final name = getName(newRoute);
    _stack.pop();
    _stack.push(name);
  }

  bool hasRoute(String routeName) {
    return _stack.contains(routeName);
  }
}
