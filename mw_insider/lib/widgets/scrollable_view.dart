import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/theming/themes.dart';

class ScrollableView extends StatelessWidget {
  const ScrollableView({
    Key? key,
    required this.screenHeightFactor,
    required this.minHeight,
    required this.child,
    this.color,
  }) : super(key: key);

  final Widget child;
  final double minHeight;
  final double screenHeightFactor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: context.theme.extension<MyColors>()!.overScrollColor!,
      child: SingleChildScrollView(
        child: Container(
          color: color,
          child: SizedBox(
            height: max(minHeight,
                MediaQuery.of(context).size.height * screenHeightFactor),
            child: child,
          ),
        ),
      ),
    );
  }
}
