import 'package:flutter/material.dart';
import 'package:neumorphic_design_app/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ScrollController> _scrollController = [
    ScrollController(initialScrollOffset: 0.0),
    ScrollController(initialScrollOffset: 0.0),
    ScrollController(initialScrollOffset: 0.0),
    ScrollController(initialScrollOffset: 0.0),
    ScrollController(initialScrollOffset: 0.0),
  ];

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

  Orientation get isPortrait => MediaQuery.of(context).orientation;

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
  void dispose() {
    _scrollController.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: 5,
          itemExtent: cardHeight,
          primary: true,
          itemBuilder: (BuildContext context, int index) {
            return ListView.builder(
              controller: _scrollController[index],
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  top: verticalPadding,
                  bottom: verticalPadding,
                ),
                child: CardWidget(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CardDimensions {
  final double cardHeight;
  final double cardWidth;

  CardDimensions(this.cardHeight, this.cardWidth);
}
