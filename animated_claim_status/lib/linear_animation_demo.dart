import 'package:flutter/material.dart';

class LinearAnimationDemo extends StatefulWidget {
  const LinearAnimationDemo({super.key});

  @override
  State<LinearAnimationDemo> createState() => _LinearAnimationDemoState();
}

class _LinearAnimationDemoState extends State<LinearAnimationDemo>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool year2023 = true;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(
          lowerBound: 0,
          upperBound: 1,
          vsync: this, duration: const Duration(seconds: 5))
          ..addListener(() {
            setState(() {});
          })
          ..repeat(reverse: false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 16.0,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LinearProgressIndicator(
              color: Colors.green,
               year2023: false,
              value: controller.upperBound,
            ),
          ),
        ],
      ),
    );
  }
}
