import 'package:flutter/material.dart';
import 'package:neumorphic_design_app/home3/size_provider2.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key key,
    @required this.padding,
    @required this.dimensionWidth,
    @required this.text,
  }) : super(key: key);

  final double padding;
  final int dimensionWidth;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Card(
        margin: EdgeInsets.all(0),
        elevation: 0,
        child: Container(
          child: Center(
            child: Text(text),
          ),
          width: SizeProvider2.screenWidth / dimensionWidth -
              padding * 2,
          color: Colors.blue,
        ),
      ),
    );
  }
}
