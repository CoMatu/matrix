import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:neumorphic_design_app/home3/sizes.dart';

class HomePage4 extends StatefulWidget {
  final int dimensionWidth;
  final int dimensionHeight;
  final double padding;

  HomePage4({@required this.dimensionWidth,
    @required this.padding,
    @required this.dimensionHeight});

  @override
  _HomePage4State createState() => _HomePage4State();
}

class _HomePage4State extends State<HomePage4> {
  static const int count = 1000;
  int _dimensionWidth;
  int _dimensionHeight;
  double _padding;
  int _screensCount;
  int _gridItemsCount;

  // List<ScrollController> horizontalControllers = [];
  // List<double> horizontalControllersOffsets = [];
  // ScrollController verticalController;

  @override
  void initState() {
    super.initState();
    _dimensionWidth = widget.dimensionWidth;
    _dimensionHeight = widget.dimensionHeight;
    if (widget.padding > Sizes.screenWidth)
      _padding = 8;
    else
      _padding = widget.padding;
    // for (int i = 0; i < count; i++) {
    //   horizontalControllersOffsets.add(0.0);
    //   ScrollController controller = ScrollController(
    //       initialScrollOffset: horizontalControllersOffsets[i]);
    //   controller.addListener(() {
    //     setState(() {
    //       horizontalControllersOffsets[i] = controller.offset;
    //     });
    //   });
    //   horizontalControllers.add(controller);
    // }
    // verticalController = ScrollController();
    // verticalController.addListener(() {
    //   setState(() {
    //     for (int i = 0; i < count; i++) {
    //       if (horizontalControllers[i].hasClients)
    //         horizontalControllers[i].jumpTo(horizontalControllersOffsets[i]);
    //     }
    //   });
    // });

    _screensCount = 3;
    _gridItemsCount = _dimensionWidth * _dimensionHeight;
    SliverGridDelegate _sliverGridDelegate =
    SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _dimensionHeight);
  }

  PageController _pageController = PageController();
  static bool _slider = true;
  Size _pageViewSize;

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: MeasureSize(
          onChange: (size) {
            _pageViewSize = size;
          },
          child: PageView.builder(
            scrollDirection: _slider ? Axis.vertical : Axis.horizontal,
            itemCount: count,
            itemBuilder: (BuildContext context, int index) => Container(
              height: Sizes.screenHeight / _dimensionHeight,
              width: Sizes.screenWidth / _dimensionWidth,
              color: Colors.red,
              child: Center(
                child: Text(
                  '$index',
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
            controller: _pageController,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              setState(() {
                _slider = _slider ? false : true;
                // Recalculate viewport dimension
                _pageController.position.applyViewportDimension(
                    _slider ? _pageViewSize.height : _pageViewSize.width);
              }),
        ),
      );
}

typedef void OnWidgetSizeChange(Size size);

class MeasureSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key key,
    @required this.onChange,
    @required this.child,
  }) : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}

/*
Container(
            padding: EdgeInsets.only(top: SizeProvider2.topPadding),
            child: ListView.builder(
              // controller: verticalController,
              scrollDirection: Axis.horizontal,
              itemCount: count,
              itemBuilder: (BuildContext context, int i) {
                return Builder(
                  builder: (BuildContext context) {
                    List<Widget> listH = [];
                    for (int i = 0; i < _dimensionHeight; i++) {
                      listH.add(
                        Builder(
                          builder: (BuildContext context) {
                            List<Widget> list = [];
                            for (int j = 0; j < _dimensionWidth; j++) {
                              list.add(
                                Container(
                                  height: SizeProvider2.screenHeight /
                                          _dimensionHeight -
                                      SizeProvider2.topPadding / _dimensionHeight,
                                  child: CustomCard(
                                    padding: _padding,
                                    dimensionWidth: _dimensionWidth,
                                    text: '$i - $j',
                                  ),
                                ),
                              );
                            }
                            return Row(
                              children: list,
                            );
                          },
                        ),
                      );
                    }
                    return Column(
                      children: listH,
                    );
                  },
                );
              },
            ),
          ),
 */
