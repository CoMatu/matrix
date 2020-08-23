import 'package:flutter/material.dart';
import 'dart:math';

import 'package:neumorphic_design_app/card_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _controllerRow = PageController();
  var _controllerColumn = PageController();

  List<Widget> listWidget = List<Widget>();
  List<List<Widget>> listOfLists = List<List<Widget>>();
  List<Widget> _getNeumorphicButton(int index) {
    for (int i = 0; i < 8; i++) {
      listWidget.add(_buildNeumorphicButton(1));
    }
    listOfLists.add(listWidget);
    listWidget = List<Widget>();
    return listOfLists[index];
  }

  double page = 1;
  int currentPage = 1;
  double page1 = 1;
  int currentPage1 = 1;
  double page2 = 1;
  int currentPage2 = 1;
  PageController pageController_zoom0;
  PageController pageController_zoom1;
  PageController pageController_zoom2;

  @override
  void initState() {
    pageController_zoom0 = PageController(initialPage: currentPage);
    pageController_zoom1 = PageController(initialPage: currentPage);
    pageController_zoom2 = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageController_zoom0 = PageController(
      viewportFraction:
          1, //  viewportFraction бессмысленно менять так как Transform забирает все пространство одинаково в pageview /s/s/s 0.353 * (MediaQuery.of(context).size.height /MediaQuery.of(context).size.width) + 0.254,
      initialPage: 1,
    );
    final pageController_zoom1 = PageController(
      viewportFraction: 1,
      initialPage: 1,
    );
    final pageController_zoom2 = PageController(
      viewportFraction: 1,
      initialPage: 1,
    );
    _controllerRow = PageController(
      viewportFraction: 0.353 *
              (MediaQuery.of(context).size.height /
                  MediaQuery.of(context).size.width) +
          0.254,
    );
    _controllerColumn = PageController(
      viewportFraction: -0.128 *
              (MediaQuery.of(context).size.height /
                  MediaQuery.of(context).size.width) +
          1.1,
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: PageView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    if (notification is ScrollUpdateNotification) {
                      setState(() {
                        page = pageController_zoom0.page;
                      });
                    }
                  },
                  child: PageView.builder(
                    onPageChanged: (pos) {
                      setState(() {
                        currentPage = pos;
                      });
                    },
                    controller: pageController_zoom0,
                    itemCount: _getNeumorphicButton(0).length,
                    itemBuilder: (context, index) {
                      final scale = max(0.35, (1 - (index - page).abs()));
                      return _buildNeumorphicButton(scale);
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    if (notification is ScrollUpdateNotification) {
                      setState(() {
                        page1 = pageController_zoom1.page;
                      });
                    }
                  },
                  child: PageView.builder(
                    onPageChanged: (pos1) {
                      setState(() {
                        currentPage1 = pos1;
                      });
                    },
                    controller: pageController_zoom1,
                    itemCount: _getNeumorphicButton(1).length,
                    itemBuilder: (context, index) {
                      final scale1 = max(0.4, (1 - (index - page1).abs()));
                      return _buildNeumorphicButton(scale1);
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    if (notification is ScrollUpdateNotification) {
                      setState(() {
                        page2 = pageController_zoom2.page;
                      });
                    }
                  },
                  child: PageView.builder(
                    onPageChanged: (pos2) {
                      setState(() {
                        currentPage2 = pos2;
                      });
                    },
                    controller: pageController_zoom2,
                    itemCount: _getNeumorphicButton(1).length,
                    itemBuilder: (context, index) {
                      final scale2 = max(0.4, (1 - (index - page2).abs()));
                      return _buildNeumorphicButton(scale2);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
        scrollDirection: Axis.vertical,
        controller: _controllerColumn,
      ),
    );
  }

  Widget _buildNeumorphicButton(double scale_ratio) {
    return Transform.scale(
      scale: scale_ratio,
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.001,
            top: MediaQuery.of(context).size.width * 0.001),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Container(
              height: (MediaQuery.of(context).size.height /
                          MediaQuery.of(context).size.width <
                      1.5)
                  ? MediaQuery.of(context).size.height * 0.94
                  : (MediaQuery.of(context).size.width * 0.94) * 1.72,
              width: (MediaQuery.of(context).size.height /
                          MediaQuery.of(context).size.width >
                      1.5)
                  ? MediaQuery.of(context).size.width * 0.94
                  : (MediaQuery.of(context).size.height * 0.94) / 1.72,
              child: CardWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
