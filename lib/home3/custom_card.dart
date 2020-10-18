import 'dart:math';

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key key,
    @required this.width,
    @required this.height,
    @required this.text,
  }) : super(key: key);

  final double width;
  final double height;
  final String text;
  Color randomColor() {
    int r = Random().nextInt(10);
    switch (r) {
      case 0: return Colors.red;
      case 1: return Colors.green;
      case 2: return Colors.blue;
      case 3: return Colors.orange;
      case 4: return Colors.black;
      case 5: return Colors.indigo;
      case 6: return Colors.grey;
      case 7: return Colors.brown;
      case 8: return Colors.cyanAccent;
      case 9: return Colors.pink;
      case 10: return Colors.yellowAccent;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: width - 6,
        height: height - 6,
        child: Card(
          color: Colors.indigo[200],
          elevation: 2,
          child: Center(
            child: Text(text),
          ),
        ),
      ),
      width: width,
      height: height,
      // color: randomColor(),
    );
  }
}
