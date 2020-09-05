import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:neumorphic_design_app/data/parametrs.dart';
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
        return buildPageViewHorizontal(context, parameters);
      },
    );
  }

  Widget buildPageViewHorizontal(
      BuildContext context, CardParameters parameters) {
    return PageView.builder(
      itemCount: _itemCount,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return buildGridNew(widget.dimension, parameters);
      },
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
                height: parameters.cardHeight - parameters.cardPadding,
                width: parameters.cardWidth,
                child: Padding(
                  padding: EdgeInsets.all(parameters.cardPadding),
                  child: CardWidget(),
                )),
          ),
        ),
      ),
    );
  }
}
