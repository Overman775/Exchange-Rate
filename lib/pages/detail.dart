import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(this.base, {Key key}) : super(key: key);

  final String base;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.base),
      ),
    );
  }
}
