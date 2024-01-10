import 'package:flutter/widgets.dart';

class MvcProvider {
  static final MvcProvider _instancia = MvcProvider._internal();
  factory MvcProvider() {
    return _instancia;
  }

  late BuildContext? context;

  MvcProvider._internal();

  set setContext(BuildContext context) {
    this.context = context;
  }
}
