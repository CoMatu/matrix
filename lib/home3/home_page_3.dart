import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:neumorphic_design_app/home3/horizontal_list.dart';
import 'package:neumorphic_design_app/home3/size_provider2.dart';

class HomePage3 extends StatefulWidget {
  final int dimensionWidth;
  final int dimensionHeight;
  final double padding;

  HomePage3(
      {@required this.dimensionWidth,
      @required this.padding,
      @required this.dimensionHeight});

  @override
  _HomePage3State createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  static const int count = 10;
  List<ScrollController> horizontalControllers = [];
  List<double> horizontalControllersOffsets = [];
  double _paddingWidth;
  double _paddingHeight;
  ScrollController verticalController;
  int _dimensionWidth;
  int _dimensionHeight;

  final double _aspectRatio = 4 / 3;
  // final double _aspectRatio = 16 / 9;

  @override
  void initState() {
    super.initState();
    _dimensionWidth = widget.dimensionWidth;
// _dimensionHeight = widget.dimensionHeight;
    // print(SizeProvider2.screenHeight * _aspectRatio);
    // print(_aspectRatio);
    // print(_dimensionWidth/_dimensionHeight);
// _dimensionHeight = 5;
    if (widget.padding > SizeProvider2.screenWidth)
      _paddingWidth = 8;
    else
      _paddingWidth = widget.padding;
    for (int i = 0; i < count; i++) {
      horizontalControllersOffsets.add(0.0);
      ScrollController controller = ScrollController(
          initialScrollOffset: horizontalControllersOffsets[i]);
      controller.addListener(() {
        setState(() {
          horizontalControllersOffsets[i] = controller.offset;
        });
      });
      horizontalControllers.add(controller);
    }
    verticalController = ScrollController();
    verticalController.addListener(() {
      setState(() {
        for (int i = 0; i < count; i++) {
          if (horizontalControllers[i].hasClients)
            horizontalControllers[i].jumpTo(horizontalControllersOffsets[i]);
        }
      });
    });

    // _padding = 0;
    // double additionPadding = 0;
    //   cardWidth = SizeProvider2.screenWidth / _dimensionWidth - _padding*2;
    //   cardHeight = cardWidth * _aspectRatio;
    //   double rowsPerScreen = (SizeProvider2.screenHeight -
    //           SizeProvider2.screenHeight % cardHeight) /
    //       cardHeight;
    //   additionPadding =
    //       SizeProvider2.screenHeight % cardHeight / rowsPerScreen;
    //   print('rowsPerScreen: ' + rowsPerScreen.toString());
    //   print('additionPadding: ' + additionPadding.toString());
    // print('setted aspect ratio: ' + _aspectRatio.toString());
    // print('calc aspect ratio: ' + (cardHeight / cardWidth).toString());
    // print(_padding);

    // print(cardHeight1);
    // cardHeight = SizeProvider2.screenHeight / _dimensionHeight -
    // SizeProvider2.topPadding / _dimensionHeight;

    cardWidth =
        (SizeProvider2.screenWidth - _paddingWidth * _dimensionWidth * 2) /
            _dimensionWidth;
    cardHeight = cardWidth * _aspectRatio;
    double rowsPerScreen = (SizeProvider2.screenHeight -
            SizeProvider2.topPadding -
            (SizeProvider2.screenHeight - SizeProvider2.topPadding) %
                cardHeight) /
        cardHeight;

    _paddingHeight =
        (SizeProvider2.screenHeight - SizeProvider2.topPadding) %
            cardHeight /
            rowsPerScreen/2;
    // _paddingHeight = 0;
    print(_paddingHeight);
    print('setted aspect ratio: ' + _aspectRatio.toString());
    print('calc aspect ratio: ' + (cardHeight / cardWidth).toString());
  }

  double cardWidth;
  double cardHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            controller: verticalController,
            scrollDirection: Axis.vertical,
            itemCount: count,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: _paddingHeight),
                child: HorizontalList(
                  cardHeightPixels: cardHeight,
                  controller: horizontalControllers[i],
                  count: count,
                  paddingWidth: _paddingWidth,
                  paddingHeight: 0,
                  cardWidthPixels: cardWidth,
                  text: '$i - ',
                ),
              );
            },
          ),
          Container(
            width: _paddingWidth * 3,
            child: GestureDetector(
              onHorizontalDragEnd: (dragStartDetals) {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
