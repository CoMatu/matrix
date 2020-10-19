import 'package:flutter/material.dart';
import 'package:neumorphic_design_app/presentation/custom_scroll_physics.dart';
import 'package:neumorphic_design_app/scrollTypeOne/custom_card.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    Key key,
    @required this.cardHeightPixels,
    @required this.controller,
    @required this.count,
    @required this.text,
    @required this.paddingWidth,
    @required this.cardWidthPixels,
    @required this.physics,
  }) : super(key: key);

  final double cardHeightPixels;
  final ScrollController controller;
  final int count;
  final String text;
  final double paddingWidth;
  final double cardWidthPixels;
  final CustomScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeightPixels,
      child: ListView.builder(
        controller: controller,
        physics: physics,
        scrollDirection: Axis.horizontal,
        itemCount: count,
        itemBuilder: (BuildContext context, int j) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: paddingWidth),
            child: CustomCard(
              width: cardWidthPixels,
              height: cardHeightPixels,
              text: '$text $j',
            ),
          );
        },
      ),
    );
  }
}
