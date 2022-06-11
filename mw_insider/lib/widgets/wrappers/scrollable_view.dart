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
    required this.child,
    this.color,
  }) : super(key: key);

  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: NoOverScrollGlowBehavior(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(color: color, child: child),
            ),
          ],
        ));
    // return ScrollConfiguration(
    //   behavior: NoOverScrollGlowBehavior(),
    //   child: SingleChildScrollView(
    //     child: Container(
    //       color: color,
    //       child: ConstrainedBox(
    //         constraints: BoxConstraints(minHeight: minHeight),
    //         child: child,
    //       ),
    //     ),
    //   ),
    // );
  }
}
