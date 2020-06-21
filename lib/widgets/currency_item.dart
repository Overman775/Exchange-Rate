import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CurrencyItem extends StatelessWidget {
  const CurrencyItem(this.base, {Key key, this.add = false}) : super(key: key);

  final String base;
  final bool add;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      base,
      style: TextStyle(color: Colors.white, fontSize: 50),
    ));
  }
}
