import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Ball extends StatefulWidget {
  const Ball({
    Key? key,
    required this.size,
  }) : super(key: key);
  final Size size;
  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> with SingleTickerProviderStateMixin {
  late Animation<double> _ballAnimation;
  late AnimationController ballController;
  @override
  void initState() {
    super.initState();
    generateList();
    ballController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          ballController.forward();
        }
        print(status);
      });
    _ballAnimation = Tween<double>(begin: widget.size.height + 100, end: 10).animate(
        CurvedAnimation(parent: ballController, curve: GravityCurve()));
    final index = math.Random().nextInt(positions.length);
    dx = positions[index];
    ballController.forward();
  }

  @override
  void dispose() {
    ballController.dispose();
    super.dispose();
  }

  void generateList() {
    for (double i = -widget.size.width / 2;
        i < widget.size.width / 2;
        i += 50.0) {
      positions.add(i);
    }
  }

  Widget ball({double? size}) {
    return Container(
      height: size ?? 20,
      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    );
  }

  double? dx;
  List<double> positions = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
        animation: _ballAnimation,
        builder: (context, child) {
          return Transform.translate(
              offset: Offset(dx!, _ballAnimation.value), child: ball());
        });
  }
}

class GravityCurve extends Curve {
  // 0-1
  @override
  double transformInternal(double t) {
    return math.sin(math.pi * t);
    // return t < 0.5 ? sin(pi * t) : sin(3 * t * pi / 2);
  }
}