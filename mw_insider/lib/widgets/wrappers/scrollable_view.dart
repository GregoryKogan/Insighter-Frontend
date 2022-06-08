import 'dart:math';
import 'package:flutter/material.dart';

class NoOverScrollGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class ScrollableView extends StatelessWidget {
  const ScrollableView({
    Key? key,
    required this.minHeight,
    required this.child,
    this.screenHeightFactor,
    this.screenHeightOffset,
    this.color,
  }) : super(key: key);

  final Widget child;
  final double minHeight;
  final double? screenHeightFactor;
  final double? screenHeightOffset;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoOverScrollGlowBehavior(),
      child: SingleChildScrollView(
        child: Container(
          color: color,
          child: SizedBox(
            height: screenHeightFactor != null
                ? max(minHeight,
                    MediaQuery.of(context).size.height * screenHeightFactor!)
                : screenHeightOffset != null
                    ? max(
                        minHeight,
                        MediaQuery.of(context).size.height +
                            screenHeightOffset!)
                    : max(minHeight, MediaQuery.of(context).size.height),
            child: child,
          ),
        ),
      ),
    );
  }
}
