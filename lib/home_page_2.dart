import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:neumorphic_design_app/card_widget.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  var _itemCountHorizontal = 5;

  Orientation get isPortrait => MediaQuery.of(context).orientation;

  double get _height => MediaQuery.of(context).size.height;
  double get _width => MediaQuery.of(context).size.width;

  double get horizontalPadding {
    double _padd;
    if (isPortrait == Orientation.portrait) {
      _padd = _width * 0.01;
    } else {
      _padd = _width * 0.01;
    }
    return _padd;
  }

  double get verticalPadding {
    double _padd;
    if (isPortrait == Orientation.portrait) {
      _padd = cardHeight * 0.005;
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Swiper(
          itemBuilder: (context, index) => CardWidget(),
          itemCount: _itemCountHorizontal,
          loop: false,
          itemHeight: cardHeight,
        ),
      ),
    );
  }
}
