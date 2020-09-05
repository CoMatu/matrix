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
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            sizeProvider.setCardSize(
                MediaQuery.of(context).size, widget.dimension);

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
          viewportFraction: sizeProvider.parameters.viewportFraction),
      itemCount: _itemCount,
      itemBuilder: (BuildContext context, int index) {
        return buildPageViewHorizontal(context);
      },
    );
  }

  Widget buildPageViewHorizontal(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: PageView.builder(
        itemCount: _itemCount,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          /*24 is for notification bar on Android*/
          double ratio = sizeProvider.parameters.cardWidth /
              sizeProvider.parameters.cardHeight;
          return Center(child: buildGrid(context, ratio));
        },
      ),
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
            return buildGrid(context, 0.75);
          },
        );
      },
    );
  }

  Widget buildGrid(BuildContext context, double ratio) {
    return Center(
      child: GridView.count(
        crossAxisCount: widget.dimension,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        childAspectRatio: ratio,
        children: List.generate(
          widget.dimension * widget.dimension,
          (index) => CardWidget(),
        ),
      ),
    );
  }
}
