import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';

class CircularImageAnimation extends StatefulWidget {
  @override
  _CircularImageAnimationState createState() => _CircularImageAnimationState();
}

class _CircularImageAnimationState extends State<CircularImageAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final ChargingController chargingController = Get.find<ChargingController>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Faster flip
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: math.pi).animate(_controller);

    chargingController.isCharging.listen((charging) {
      if (charging) {
        _controller.repeat(reverse: true); // Start animation on "Start"
      } else {
        _controller.stop(); // Stop animation on "Stop"
      }
    });

    if (chargingController.isCharging.value) {
      _controller.repeat(reverse: true);
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(_animation.value),
            child: child,
          );
        },
        child: Image.asset(
          'lib/assets/img_1.png',
          height: 150,
          width: 300,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class ChargingController extends GetxController {
  var selectedMode1 = 0.obs;
  var isCharging = false.obs; // Add this

  void selectMode1(int mode) {
    selectedMode1.value = mode;
  }

  void toggleCharging(bool charging) {
    isCharging.value = charging;
  }
}

