import 'package:flutter/material.dart';
import 'package:meditations_tracker/app/app_style_widget.dart';

class BottomUpPageTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const BottomUpPageTransition({
    Key key,
    @required this.child,
    @required this.animation,
  })  : assert(child != null),
        assert(animation != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyleWidget.of(context);
    final animationOffset =
        Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
            .chain(CurveTween(curve: appStyle.pageTransitionCurve))
            .animate(animation);

    final animationOpacity = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: appStyle.pageTransitionCurve))
        .animate(animation);

    return SlideTransition(
      position: animationOffset,
      child: FadeTransition(
        opacity: animationOpacity,
        child: child,
      ),
    );
  }
}

class FadeInTransitionPageTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const FadeInTransitionPageTransition({
    Key key,
    @required this.child,
    @required this.animation,
  })  : assert(child != null),
        assert(animation != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyleWidget.of(context);
    final animationStyled = CurvedAnimation(
      parent: animation,
      curve: appStyle.pageTransitionCurve,
    );
    return FadeTransition(opacity: animationStyled, child: child);
  }
}
