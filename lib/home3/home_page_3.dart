
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:neumorphic_design_app/home3/horizontal_list.dart';
import 'package:neumorphic_design_app/home3/sizes.dart';

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
  static const int count = 1000;
  List<ScrollController> horizontalControllers = [];
  List<double> horizontalControllersOffsets = [];
  double _paddingWidth;
  double _paddingHeight;
  ScrollController verticalController;
  int _dimensionWidth;

  final double _aspectRatio = 4 / 3;

  // final double _aspectRatio = 16 / 9;

  @override
  void initState() {
    super.initState();
    _dimensionWidth = widget.dimensionWidth;
    if (widget.padding > Sizes.screenWidth)
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
    double screenHeightMinusTopOSBar = Sizes.screenHeight - Sizes.topPadding;
    cardWidth = (Sizes.screenWidth - _paddingWidth * _dimensionWidth * 2) /
        _dimensionWidth;
    cardHeight = cardWidth * _aspectRatio;

    double rowsPerScreen =
        (screenHeightMinusTopOSBar - screenHeightMinusTopOSBar % cardHeight) /
            cardHeight;
    // если карточек много и отступ большой то получается хрень или ошибка
    _paddingHeight = screenHeightMinusTopOSBar % cardHeight / rowsPerScreen / 2;
    print(_paddingHeight);
  }

  double cardWidth;
  double cardHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        (cardHeight > 4 || cardWidth > 4)
            ? ListView.builder(
                controller: verticalController,
                scrollDirection: Axis.vertical,
                itemCount: count,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: _paddingHeight),
                    child: HorizontalList(
                      cardHeightPixels: cardHeight,
                      controller: horizontalControllers[i],
                      count: count,
                      paddingWidth: _paddingWidth,
                      cardWidthPixels: cardWidth,
                      text: '$i - ',
                    ),
                  );
                },
              )
            : Center(
                child: Text('Некорректно заданы параметры сетки',
                    textAlign: TextAlign.center),
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
    ));
  }
}
