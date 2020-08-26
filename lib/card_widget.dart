import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1 / 1.7,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(45.0)),
          ),
          color: Colors.grey[50],
//        elevation: 10,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.asset('assets/third.jpg', fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 45.0, right: 15.0, top: 15.0),
                    child: Center(
                      child: AutoSizeText(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
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
        ),
      ),
    );
  }
}

/* Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(45.0)),
      ),
      color: Colors.grey[50],
      elevation: 10,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset('assets/third.jpg', fit: BoxFit.fill),
              Padding(
                padding:
                    const EdgeInsets.only(left: 45.0, right: 15.0, top: 15.0),
                child: Center(
                  child: AutoSizeText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
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
    ) */
