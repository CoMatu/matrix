import 'package:flutter/material.dart';
import 'package:neumorphic_design_app/home3/custom_card.dart';
import 'package:neumorphic_design_app/home3/size_provider2.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    Key key,
    @required this.height,
    @required this.controller,
    @required this.count,
    @required this.text,
    @required this.padding,
    @required this.dimensionWidth,
  }) : super(key: key);

  final double height;
  final ScrollController controller;
  final int count;
  final String text;
  final double padding;
  final int dimensionWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
          // - SizeProvider2.topPadding / _dimensionHeight,
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: count,
        itemBuilder: (BuildContext context, int j) {
          return CustomCard(
            padding: padding,
            dimensionWidth: dimensionWidth,
            text: '$text $j',
          );
        },
      ),
    );
  }
}