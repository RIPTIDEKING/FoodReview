import 'package:flutter/material.dart';

class OrienValue {
  final BuildContext cont;
  OrienValue(this.cont);

  double dewWidth(int opt) {
    final double deviceWidth = MediaQuery.of(cont).size.width;
    final double finalWidth =
        MediaQuery.of(cont).orientation == Orientation.landscape
            ? deviceWidth * 0.8
            : deviceWidth * 0.95;
    final double finalPad = (deviceWidth - finalWidth) / 2;
    if (opt == 1) {
      return finalWidth;
    }
    if (opt == 2) {
      return finalPad;
    }
    return 0.0;
  }
}
