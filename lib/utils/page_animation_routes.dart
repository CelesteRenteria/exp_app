import 'package:flutter/material.dart';

class PageAnimationRoutes extends PageRouteBuilder {
  final Widget widget;
  final double ejeX;
  final double ejeY;
  PageAnimationRoutes(
      {required this.widget, required this.ejeX, required this.ejeY})
      : super(
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.easeOutCubic);
              return ScaleTransition(
                scale: animation,
                alignment: Alignment(ejeX, ejeY),
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}
