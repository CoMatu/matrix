import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:neumorphic_design_app/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _itemCount = 10;

  List<PageController> _controllers;
  PageController _verticalController;

  Orientation get isPortrait => MediaQuery.of(context).orientation;

  double get _height => MediaQuery.of(context).size.height;
  double get _width => MediaQuery.of(context).size.width;

  double get horizontalPadding {
    double _padd;
    if (isPortrait == Orientation.portrait) {
      _padd = (_width - cardWidth) / 1.8;
    } else {
      _padd = _width * 0.01;
    }
    return _padd;
  }

  double get verticalPadding => _height * 0.95;

  double get cardWidth {
    var cardW = _width * 0.9;
    if (cardW > _height / 1.7) {
      cardW = _height / 1.77;
    }
    return cardW;
  }

  @override
  void didChangeDependencies() {
    final _h = MediaQuery.of(context).size.height;
    final _w = MediaQuery.of(context).size.width;
    final _ratio = _w / _h;
    print(_w / _h);
    final _fraction = _ratio > 0.6 ? 0.85 : 0.7;
    _verticalController =
        PageController(viewportFraction: _fraction, initialPage: 1);
    _controllers = [];
    for (int i = 0; i < _itemCount; i++) {
      final controller = PageController(viewportFraction: 0.9);
      _controllers.add(controller);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          controller:
              isPortrait == Orientation.portrait ? _verticalController : null,
          itemCount: _itemCount,
          itemBuilder: (BuildContext context, int index) =>
              isPortrait == Orientation.portrait
                  ? buildHorizontalPageView()
                  : buildHorizontalListView(),
        ),
      ),
    );
  }

  ListView buildHorizontalListView() {
    return ListView.builder(
      physics: PageScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: _itemCount,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CardWidget(),
      ),
    );
  }

  PageView buildHorizontalPageView() {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              top: 5,
              bottom: 5),
          child: CardWidget(),
        );
      },
    );
  }
}
