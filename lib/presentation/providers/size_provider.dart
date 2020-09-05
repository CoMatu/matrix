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

  CardParameters get parameters => _parameters;

  void setCardSize(Size size, int dimension) {
    double koefVisibility = 0.94;
    double cardRatio = 1.7;
    double statusBarHeight = 24;

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
    _parameters.cardPadding = _parameters.cardHeight * 0.03;

    print(parameters);
    notifyListeners();
  }
}
