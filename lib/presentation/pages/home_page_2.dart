import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:neumorphic_design_app/presentation/providers/size_provider.dart';
import 'package:neumorphic_design_app/presentation/widgets/card_widget.dart';
import 'package:provider/provider.dart';

class HomePage2 extends StatefulWidget {
  final int dimension;
  const HomePage2(this.dimension, {Key key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final _itemCount = 12; // количество вью
  SizeProvider sizeProvider;

  @override
  void initState() {
    super.initState();
    sizeProvider = Provider.of<SizeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 500) {
              return buildVerticalLayout();
            }
            return buildHorizontalLayout();
          },
        ),
      ),
    );
  }

  Widget buildVerticalLayout() {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: PageController(
          viewportFraction: sizeProvider.parameters.viewportFraction,
          initialPage: sizeProvider.parameters.initialPage),
      itemCount: _itemCount,
      itemBuilder: (BuildContext context, int index) {
        return buildPageViewHorizontal(context);
      },
    );
  }

  Widget buildPageViewHorizontal(BuildContext context) {
    return PageView.builder(
      itemCount: _itemCount,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return buildGridNew(widget.dimension);
      },
    );
  }

  Widget buildHorizontalLayout() {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: _itemCount,
      itemBuilder: (BuildContext context, int index) {
        return PageView.builder(
          controller: PageController(viewportFraction: 0.4, initialPage: 1),
          itemCount: _itemCount,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Center(child: buildGrid(context, 0.75));
          },
        );
      },
    );
  }

  Widget buildGrid(BuildContext context, double ratio) {
    return GridView.count(
      crossAxisCount: widget.dimension,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      controller: ScrollController(keepScrollOffset: false),
      childAspectRatio: ratio,
      children: List.generate(
        widget.dimension * widget.dimension,
        (index) => Padding(
          padding: EdgeInsets.all(sizeProvider.parameters.cardPadding),
          child: CardWidget(),
        ),
      ),
    );
  }

  Widget buildGridNew(int dimension) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        widget.dimension,
        (index) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            widget.dimension,
            (index) => Container(
                height: sizeProvider.parameters.cardHeight -
                    sizeProvider.parameters.cardPadding,
                width: sizeProvider.parameters.cardWidth,
                child: Padding(
                  padding: EdgeInsets.all(sizeProvider.parameters.cardPadding),
                  child: CardWidget(),
                )),
          ),
        ),
      ),
    );
  }
}
