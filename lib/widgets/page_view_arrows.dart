import 'package:flutter/material.dart';

class PageViewArrows extends AnimatedWidget {
  const PageViewArrows({
    @required this.controller,
    @required this.itemCount,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.ease,
    this.color = Colors.white,
    this.disabledColor,
  }) : super(listenable: controller);

  final PageController controller;
  final Duration duration;
  final Curve curve;
  final Color color;
  final Color disabledColor;
  final int itemCount;

  void _goLeft() => controller.animateToPage(
        controller.page.ceil() - 1,
        duration: duration,
        curve: curve,
      );

  void _goRight() => controller.animateToPage(
        controller.page.ceil() + 1,
        duration: duration,
        curve: curve,
      );

  num get curPage => controller.page ?? controller.initialPage;
  bool get _isButtonLeftDisabled => curPage < 0.5;
  bool get _isButtonRightDisabled => curPage >= itemCount - 1.5;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedOpacity(
          opacity: _isButtonLeftDisabled ? 0.5 : 1,
          duration: duration,
          child: Material(
              type: MaterialType.transparency,
              child: Ink(
                decoration: BoxDecoration(
                  border: Border.all(color: color, width: 2.0),
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(1000.0),
                  onTap: _isButtonLeftDisabled ? null : _goLeft,
                  splashColor: color.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_left,
                      size: 30.0,
                      color: color,
                    ),
                  ),
                ),
              )),
        ),
        const Spacer(),
        AnimatedOpacity(
          opacity: _isButtonRightDisabled ? 0.5 : 1,
          duration: duration,
          child: Material(
              type: MaterialType.transparency,
              child: Ink(
                decoration: BoxDecoration(
                  border: Border.all(color: color, width: 2.0),
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(1000.0),
                  onTap: _isButtonRightDisabled ? null : _goRight,
                  splashColor: color.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_right,
                      size: 30.0,
                      color: color,
                    ),
                  ),
                ),
              )),
        )
      ],
    );
  }
}
