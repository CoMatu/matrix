import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollTypeTwo extends StatefulWidget {
  final int dimension;
  final double padding;

  ScrollTypeTwo({
    @required this.dimension,
    @required this.padding,
  });

  @override
  _ScrollTypeTwoState createState() => _ScrollTypeTwoState();
}

class _ScrollTypeTwoState extends State<ScrollTypeTwo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _padding = widget.padding;
  }

  double _padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 1000,
        itemBuilder: (context, i) {
          return Container(
            height: 100,
            child: PageView.builder(
              itemCount: 1000,
              itemBuilder: (context, j) {
                return Padding(
                  padding: EdgeInsets.all(_padding),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.blue,
                    child: Center(child: Text('$i - $j')),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
