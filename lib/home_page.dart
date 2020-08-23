import 'package:flutter/material.dart';
import 'package:neumorphic_design_app/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ScrollController> _horizontalControllers = [
    ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController(),
  ];

  ScrollController _verticalController = ScrollController();

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
  void dispose() {
    _horizontalControllers.forEach((element) {
      element.dispose();
    });
    _verticalController.dispose();
    super.dispose();
  }

  void _onEndScrollVertical(ScrollMetrics metrics) {
    print("scroll before = ${metrics.extentBefore}");
    print("scroll after = ${metrics.extentAfter}");
    print("scroll inside = ${metrics.extentInside}");
    print("item HEIGHT => $cardHeight");

    var halfOfTheHeight = cardHeight / 2;
    var offsetOfItem = metrics.extentBefore % cardHeight;
    if (offsetOfItem < halfOfTheHeight) {
      final offset = metrics.extentBefore - offsetOfItem;
      print("offsetOfItem1 = $offsetOfItem offset = $offset");
      Future.delayed(Duration(milliseconds: 50), () {
        _verticalController.animateTo(offset,
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn);
      });
    } else if (offsetOfItem > halfOfTheHeight) {
      final offset = metrics.extentBefore + offsetOfItem;
      print("offsetOfItem2 = $offsetOfItem offset = $offset");
      Future.delayed(Duration(milliseconds: 50), () {
        _verticalController.animateTo(offset,
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn);
      });
    }
  }

  void _onEndScrollHorizontal(ScrollMetrics metrics, int index) {
    print("scroll before = ${metrics.extentBefore}");
    print("scroll after = ${metrics.extentAfter}");
    print("scroll inside = ${metrics.extentInside}");
    print("item WIDTH => $cardWidth");

    var halfOfTheWidth = _width / 2;
    var offsetOfItem = metrics.extentBefore % _width;
    if (offsetOfItem < halfOfTheWidth) {
      final offset = metrics.extentBefore - offsetOfItem;
      print("offsetOfItem1 = $offsetOfItem offset = $offset");
      Future.delayed(Duration(milliseconds: 50), () {
        _horizontalControllers[index].animateTo(offset,
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn);
      });
    } else if (offsetOfItem > halfOfTheWidth) {
      final offset = metrics.extentBefore + offsetOfItem;
      print("offsetOfItem2 = $offsetOfItem offset = $offset");
      Future.delayed(Duration(milliseconds: 50), () {
        _horizontalControllers[index].animateTo(offset,
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollEndNotification &&
                scrollNotification.depth == 0) {
              print('ScrollEndNotification ===> $scrollNotification');
              _onEndScrollVertical(scrollNotification.metrics);
            }
            return null;
          },
          child: buildListViewVertical(),
        ),
      ),
    );
  }

  Widget buildListViewVertical() {
    return ListView.builder(
      itemCount: _itemCountHorizontal,
      itemExtent: cardHeight,
      controller: _verticalController,
      itemBuilder: (BuildContext context, int index) {
        return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollEndNotification &&
                  scrollNotification.depth == 0) {
                print('ScrollEndNotification ===> $scrollNotification');
                _onEndScrollHorizontal(scrollNotification.metrics, index);
              }
              return null;
            },
            child: buildListViewHorizontal(index));
      },
    );
  }

  Widget buildListViewHorizontal(int index) {
    return ListView.builder(
      controller: _horizontalControllers[index],
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: _itemCountHorizontal + 1,
      itemBuilder: (BuildContext context, int index) =>
          index < _itemCountHorizontal
              ? Padding(
                  padding: EdgeInsets.only(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    top: verticalPadding,
                    bottom: verticalPadding,
                  ),
                  child: CardWidget(),
                )
              : SizedBox(
                  width: 50,
                ),
    );
  }
}

class CardDimensions {
  final double cardHeight;
  final double cardWidth;

  CardDimensions(this.cardHeight, this.cardWidth);
}
