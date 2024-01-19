import 'package:flutter/material.dart';

extension Sizes on BuildContext {
  double get ancho => MediaQuery.of(this).size.width;
  double get alto => MediaQuery.of(this).size.height;

  String? get route => ModalRoute.of(this)!.settings.name;
}

String capitalizar(String input) {
  if (input.isEmpty) {
    return input;
  }

  return input[0].toUpperCase() + input.substring(1);
}
