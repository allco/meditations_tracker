import 'package:flutter/material.dart';
import 'package:meditations_tracker/app/app_style_widget.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyleWidget.of(context);
    return Container(color: Colors.green);
  }
}
