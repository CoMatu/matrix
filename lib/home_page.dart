import 'package:flutter/material.dart';
import 'package:neumorphic_design_app/card_widget.dart';
import 'package:neumorphic_design_app/custom_scroll_physics.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ScrollController> _horizontalControllers;

  ScrollController _verticalController;

  int _itemCountHorizontal = 5;

  Orientation get isPortrait => MediaQuery.of(context).orientation;

  double get _height => MediaQuery.of(context).size.height;
  double get _width => MediaQuery.of(context).size.width;

  double get horizontalPadding {
    double _padd;
    if (isPortrait == Orientation.portrait) {
      _padd = (_width - cardWidth) / 2;
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
    var cardW = _width * 0.9;
    if (cardW > _height / 1.7) {
      cardW = _height / 1.77;
    }
    return cardW;
  }

  ScrollPhysics _physics;
  List<int> pages;

  @override
  void initState() {
    _horizontalControllers = [];
    for (int i = 0; i < _itemCountHorizontal; i++) {
      final _controller = ScrollController();
      _horizontalControllers.add(_controller);
    }
    pages = List.generate(_itemCountHorizontal, (index) => index);
    _verticalController = ScrollController();
    _verticalController.addListener(() {
      if (_verticalController.position.haveDimensions && _physics == null) {
        setState(() {
          var dimension =
              _verticalController.position.maxScrollExtent / (pages.length - 1);
          _physics = CustomScrollPhysics(itemDimension: dimension);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _horizontalControllers.forEach((element) {
      element.dispose();
    });
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildListViewVertical(),
      ),
    );
  }

  Widget buildListViewVertical() {
    return ListView.builder(
      itemCount: _itemCountHorizontal,
      physics: _physics,
      itemExtent: cardHeight,
      itemBuilder: (BuildContext context, int index) {
        return buildListViewHorizontal(index);
      },
    );
  }

  Widget buildListViewHorizontal(int index) {
    return ListView.builder(
      physics: PageScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: _itemCountHorizontal,
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
  }
}

class CardDimensions {
  final double cardHeight;
  final double cardWidth;

  CardDimensions(this.cardHeight, this.cardWidth);
}
