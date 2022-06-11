import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearProgressIndicator(
            backgroundColor: context.theme.canvasColor,
            valueColor:
                AlwaysStoppedAnimation<Color>(context.theme.primaryColor),
          ),
          const SizedBox(height: 10),
          const Text('Loading'),
        ],
      ),
    );
  }
}
