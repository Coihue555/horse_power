import 'package:flutter/material.dart';

extension Sizes on BuildContext {
  double get ancho => MediaQuery.of(this).size.width;
  double get alto => MediaQuery.of(this).size.height;

  String? get route => ModalRoute.of(this)!.settings.name;
}
