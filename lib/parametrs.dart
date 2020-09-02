import 'package:flutter/cupertino.dart';

class Parameters {
  final MediaQuery mediaQuery;

  Parameters({@required this.mediaQuery});

  CardParameters getCardParameters() {



    
  }
}

class CardParameters {
  final double cardWidth;
  final double cardHeight;
  final double cardPadding;

  CardParameters(this.cardWidth, this.cardHeight, this.cardPadding);

  @override
  String toString() =>
      'CardParameters(cardWidth: $cardWidth, cardHeight: $cardHeight, cardPadding: $cardPadding)';
}
