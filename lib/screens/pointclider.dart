import 'package:flutter/material.dart';

class PointClider extends StatelessWidget {
  final double marginendend;
  final double marginendtop;
  final double marginendstart;
  final Color coloer;
  final bool selected;

  PointClider(
      {this.marginendend = 0,
      this.selected = false,
      this.marginendtop = 0,
      this.marginendstart = 0,
      required this.coloer});

  // const pageviewindecator({
  // Key? key,
  //}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(
          end: marginendend, top: marginendtop, start: marginendstart),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: coloer,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
