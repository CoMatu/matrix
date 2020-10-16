// import 'package:flutter/material.dart';
// import 'package:neumorphic_design_app/home3/custom_card.dart';
// import 'package:neumorphic_design_app/home3/size_provider2.dart';
//
// class HorizontalList extends StatelessWidget {
//   const HorizontalList({
//     Key key,
//     @required int dimensionHeight,
//     @required this.controller,
//     @required this.count,
//     @required this.text,
//     @required double padding,
//     @required int dimensionWidth,
//   })  : _dimensionHeight = dimensionHeight,
//         _padding = padding,
//         _dimensionWidth = dimensionWidth,
//         super(key: key);
//
//   final int _dimensionHeight;
//   final ScrollController controller;
//   final int count;
//   final String text;
//   final double _padding;
//   final int _dimensionWidth;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: SizeProvider2.screenHeight / _dimensionHeight -
//           SizeProvider2.topPadding / _dimensionHeight,
//       child: ListView.builder(
//         controller: controller,
//         scrollDirection: Axis.horizontal,
//         itemCount: count,
//         itemBuilder: (BuildContext context, int j) {
//           return CustomCard(
//             padding: _padding,
//             width: _dimensionWidth,
//             text: '$text $j',
//           );
//         },
//       ),
//     );
//   }
// }