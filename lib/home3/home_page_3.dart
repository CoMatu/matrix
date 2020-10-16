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
  double _padding;
  ScrollController verticalController;
  int _dimensionWidth;
  int _dimensionHeight;

  final double _aspectRatio = 9/16;

  @override
  void initState() {
    super.initState();
    _dimensionWidth = widget.dimensionWidth;
    _dimensionHeight = widget.dimensionHeight;
    print(SizeProvider2.screenHeight * _aspectRatio);
    print(_aspectRatio);
    // print(_dimensionWidth/_dimensionHeight);
_dimensionHeight = 5;
    if (widget.padding > SizeProvider2.screenWidth)
      _padding = 8;
    else
      _padding = widget.padding;
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
  }

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
              return HorizontalList(
                dimensionHeight: _dimensionHeight,
                controller: horizontalControllers[i],
                count: count,
                padding: _padding,
                dimensionWidth: _dimensionWidth,
                text: '$i - ',
              );
            },
          ),
          Container(
            width: _padding * 3,
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
