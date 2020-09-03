import 'package:flutter/cupertino.dart';

class Parameters {
  final Size size;
  final int dimension;
  final double k = 0.95; // коэффициент заполнения карточкой свободного места

  Parameters({@required this.size, this.dimension});

  CardParameters getCardParameters() {
    final cardWidthGeneral = (size.width * 0.94) / dimension;
    final cardWidthOnly = cardWidthGeneral * 0.94;
    final cardPadding = (cardWidthGeneral - cardWidthOnly) / 2;
    final cardHeight = cardWidthOnly * 1.7;
    return CardParameters(
      cardWidth: cardWidthOnly,
      cardHeight: cardHeight,
      cardPadding: cardPadding,
    );
  }
}

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