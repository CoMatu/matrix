import 'package:flutter/material.dart';
import 'package:neumorphic_design_app/data/parametrs.dart';

class SizeProvider extends ChangeNotifier {
  var _parameters = CardParameters(
    cardHeight: 0,
    cardPadding: 0,
    cardWidth: 0,
    viewportFraction: 0,
    initialPage: 0,
  );
  var _parameters2 = CardParameters(
    cardHeight: 0,
    cardPadding: 0,
    cardWidth: 0,
    viewportFraction: 0,
    initialPage: 0,
  );

  double statusBarHeight = 24;
  double cardRatio = 1.7;

  CardParameters get parameters => _parameters;
  CardParameters get paramHorizontal => _parameters2;

  void setCardSize(Size size, int dimension, double paddings) {
    double koefVisibility = 0.94;

    _parameters.cardWidth = (size.width * koefVisibility) / dimension;
    _parameters.cardHeight = _parameters.cardWidth * cardRatio;

    if (_parameters.cardHeight * dimension < size.height * koefVisibility) {
      if (_parameters.cardHeight * dimension > size.height * 0.9) {
        _parameters.viewportFraction = 1;
      }
      _parameters.viewportFraction = (_parameters.cardHeight * dimension) /
          (size.height - statusBarHeight);
      _parameters.initialPage = 1;
    } else {
      _parameters.cardHeight =
          (size.height - statusBarHeight) * koefVisibility / dimension;
      _parameters.cardWidth = _parameters.cardHeight / cardRatio;
      if (_parameters.cardWidth * dimension > 0.9) {
        _parameters.viewportFraction = 1;
      } else {
        _parameters.viewportFraction =
            (_parameters.cardWidth * dimension) / size.width;
        _parameters.initialPage = 1;
      }
    }
    _parameters.cardPadding = _parameters.cardHeight * paddings;
    print(parameters);
    notifyListeners();
  }

  void setCardSizeHorizontal(Size size, int dimension, double paddings) {
    double _height = size.width - statusBarHeight;
    double _width = size.height; // потому что развернули в горизонталь
    double cardHeight = _height / dimension;
    double cardWidth = cardHeight / cardRatio;
    double _blocWidth = cardWidth * dimension;
    double viewportF = _blocWidth / _width;
    _parameters2.cardHeight = cardHeight;
    _parameters2.cardWidth = cardWidth;
    _parameters2.viewportFraction = viewportF;
    _parameters2.initialPage = 1;
    _parameters.cardPadding = _parameters.cardHeight * paddings;
  }
}
