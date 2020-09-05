import 'package:flutter/material.dart';

class CardParameters {
  double cardWidth;
  double cardHeight;
  double cardPadding;
  double viewportFraction;

  CardParameters({
    @required this.cardWidth,
    @required this.cardHeight,
    @required this.cardPadding,
    @required this.viewportFraction,
  });

  @override
  String toString() {
    return 'CardParameters(cardWidth: ' +
        '$cardWidth, cardHeight: $cardHeight,' +
        ' cardPadding: $cardPadding, viewportFraction: $viewportFraction)';
  }
}
