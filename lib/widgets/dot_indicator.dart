import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DotsIndicator extends AnimatedWidget {
  const DotsIndicator({
    @required this.controller,
    @required this.itemCount,
    this.color = Colors.white,
    final this.size = 8.0,
    final this.zoom = 2.0,
    final this.spacing = 25.0,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.ease,
  }) : super(listenable: controller);

  final PageController controller;

  final int itemCount;
  final Color color;
  final double size;
  final double zoom;
  final double spacing;
  final Duration duration;
  final Curve curve;

  Widget _buildDot(int index) {
    final double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    final double curentZoom = 1.0 + (zoom - 1.0) * selectedness;
    return Container(
      width: spacing,
      height: size * zoom,
      child: Center(
        child: GestureDetector(
          onTap: () => _onDotTap(index),
          child: Material(
            color: color,
            type: MaterialType.circle,
            child: Container(
              width: size * curentZoom,
              height: size * curentZoom,
            ),
          ),
        ),
      ),
    );
  }

  void _onDotTap(int page) {
    controller.animateToPage(
      page,
      duration: duration,
      curve: curve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
