import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:neumorphic_design_app/card_widget.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  var _itemCount = 10;

  List<PageController> _controllers;
  PageController _verticalController;

  Orientation get isPortrait => MediaQuery.of(context).orientation;

  double get _height => MediaQuery.of(context).size.height;
  double get _width => MediaQuery.of(context).size.width;

  double get horizontalPadding {
    double _padd;
    if (isPortrait == Orientation.portrait) {
      _padd = (_width - cardWidth) / 4;
    } else {
      _padd = _width * 0.01;
    }
    return _padd;
  }

  double get verticalPadding {
    double _padd;
    if (isPortrait == Orientation.portrait) {
      _padd = (_height - cardHeight) / 2;
    } else {
      _padd = (_height - cardHeight) / 2;
    }
    return _padd;
  }

  double get cardHeight {
    double cardH;
    if (isPortrait == Orientation.portrait) {
      cardH = cardWidth * 1.7;
    } else {
      cardH = _height * 0.9;
    }
    return cardH;
  }

  double get cardWidth {
    var cardW = _width * 0.99;
    if (cardW > _height / 1.7) {
      cardW = _height / 1.77;
    }
    return cardW;
  }

  get getPageWidth => _width;

  @override
  void initState() {
    _verticalController = PageController(viewportFraction: 0.9);
    _controllers = [];
    for (int i = 0; i < _itemCount; i++) {
      final controller = PageController(viewportFraction: 0.9);
      _controllers.add(controller);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller:
            isPortrait == Orientation.portrait ? _verticalController : null,
        itemCount: _itemCount,
        itemBuilder: (BuildContext context, int index) =>
            isPortrait == Orientation.portrait
                ? PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _itemCount,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CardWidget(),
                      );
                    },
                  )
                : ListView.builder(
                    physics: PageScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _itemCount,
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CardWidget(),
                    ),
                  ),
      ),
    ));
  }
}
