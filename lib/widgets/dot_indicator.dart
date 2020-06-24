import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DotsIndicator extends AnimatedWidget {
  const DotsIndicator({
    this.controller,
    this.itemCount,
    this.indexPage,
    this.onPageSelected,
    this.color = Colors.white,
  }) : super(listenable: controller);

  final PageController controller;

  final int itemCount;
  final ValueChanged<int> onPageSelected;

  final Color color;

  static const double _kDotSize = 8.0;
  static const double _kMaxZoom = 2.0;
  static const double _kDotSpacing = 25.0;

  final int indexPage;

  Widget _buildDot(int index) {
    final double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    final double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return Container(
      width: _kDotSpacing,
      height: _kDotSize * _kMaxZoom,
      child: Center(
        child: GestureDetector(
          onTap: () => onPageSelected(index),
          child: Material(
            color: color,
            type: MaterialType.circle,
            child: Container(
              width: _kDotSize * zoom,
              height: _kDotSize * zoom,
            ),
          ),
        ),
      ),
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
