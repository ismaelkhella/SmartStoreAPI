import 'package:flutter/material.dart';

class pageviewindecator extends StatelessWidget {
  final double marginend;
  final bool selected;

  pageviewindecator({this.marginend = 0, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: marginend),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
