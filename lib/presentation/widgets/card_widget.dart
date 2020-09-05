import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(0), // delete defolt paddings
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radiusCard(context))),
      ),
      color: Colors.grey[50],
//        elevation: 10,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset('assets/third.jpg', fit: BoxFit.cover),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.01, right: 15.0, top: 15.0),
                child: Center(
                  child: AutoSizeText(
                      ' ${DateTime.now().toString()}: Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[50],
                          fontFamily: 'Roboto2'),
                      minFontSize: 10,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: AutoSizeText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce semper augue ac massa egestas, non luctus purus cursus',
                style: TextStyle(fontSize: 22),
                minFontSize: 20,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double radiusCard(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation;
    if (isPortrait == Orientation.portrait) {
      return MediaQuery.of(context).size.width * 0.05;
    } else {
      return MediaQuery.of(context).size.height * 0.03;
    }
  }
}
