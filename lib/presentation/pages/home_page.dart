import 'package:flutter/material.dart';
import 'package:neumorphic_design_app/presentation/providers/size_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          physics: PageScrollPhysics(),
          itemCount: 12,
          itemBuilder: (BuildContext context, int index) {
            final parametrs =
                Provider.of<SizeProvider>(context, listen: false).parameters;
            return Container(
              height: parametrs.cardHeight,
              child: ListView.builder(
                itemCount: 12,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: parametrs.cardHeight,
                    width: parametrs.cardWidth,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
