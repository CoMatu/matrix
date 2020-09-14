import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:neumorphic_design_app/data/parametrs.dart';
import 'package:neumorphic_design_app/presentation/custom_scroll.dart';
import 'package:neumorphic_design_app/presentation/providers/size_provider.dart';
import 'package:neumorphic_design_app/presentation/widgets/card_widget.dart';
import 'package:provider/provider.dart';

class HomePage2 extends StatefulWidget {
  final int dimension;
  final bool isLine;
  const HomePage2(this.dimension, this.isLine, {Key key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final _itemCount = 12; // количество вью
  SizeProvider sizeProvider;

  SyncScrollController _syncScroller;
  List<PageController> _pagesControllers;

  @override
  void initState() {
    super.initState();
    _pagesControllers = [];
    sizeProvider = Provider.of<SizeProvider>(context, listen: false);
    for (int i = 0; i < _itemCount; i++) {
      _pagesControllers.add(PageController());
    }
    _syncScroller = SyncScrollController(_pagesControllers);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (widget.isLine) {
              return buildLineLayout(sizeProvider.parameters);
            } else if (constraints.maxWidth < 500) {
              return buildLayout(sizeProvider.parameters);
            }
            return buildLayout(sizeProvider.paramHorizontal);
          },
        ),
      ),
    );
  }

  Widget buildLayout(CardParameters parameters) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: PageController(
          viewportFraction: parameters.viewportFraction,
          initialPage: parameters.initialPage),
      itemCount: _itemCount,
      itemBuilder: (BuildContext context, int index) {
        return buildPageViewHorizontal(context, parameters, index);
      },
    );
  }

  Widget buildPageViewHorizontal(
      BuildContext context, CardParameters parameters, int index) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        _syncScroller.processNotification(scrollInfo, _pagesControllers[index]);
        return true;
      },
      child: PageView.builder(
        controller: _pagesControllers[index],
        itemCount: _itemCount,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return buildGridNew(widget.dimension, parameters);
        },
      ),
    );
  }

  Widget buildGridNew(int dimension, CardParameters parameters) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        widget.dimension,
        (index) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            widget.dimension,
            (index) => Container(
              height: parameters.cardHeight - (parameters.cardPadding * 2),
              width: parameters.cardWidth,
              child: Padding(
                padding: EdgeInsets.all(parameters.cardPadding),
                child: CardWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLineLayout(CardParameters parameters) {
    return ListView.builder(
      itemCount: _itemCount,
      physics: PageScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: parameters.cardHeight - (parameters.cardPadding * 2),
          width: parameters.cardWidth,
          child: Padding(
            padding: EdgeInsets.all(parameters.cardPadding),
            child: CardWidget(),
          ),
        );
      },
    );
  }
}
