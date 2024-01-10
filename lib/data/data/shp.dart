import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shp {
  static final Shp _instancia = Shp._internal();
  factory Shp() {
    return _instancia;
  }

  Shp._internal();

  late SharedPreferences _prefs;

  void limpiarPreferencias() {
    _prefs.clear();
  }

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get inicializandoProyecto {
    try {
      return _prefs.getBool('inicializandoProyecto') ?? false;
    } catch (e) {
      return false;
    }
  }

  set inicializandoProyecto(bool inicializandoProyecto) {
    try {
      _prefs.setBool('inicializandoProyecto', inicializandoProyecto);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  String get tokenFirebase {
    try {
      return _prefs.getString('tokenFirebase') ?? '';
    } catch (e) {
      return '';
    }
  }

  set tokenFirebase(String tokenFirebase) {
    try {
      _prefs.setString('tokenFirebase', tokenFirebase);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  String get usuario {
    try {
      return _prefs.getString('usuario') ?? '';
    } catch (e) {
      return '';
    }
  }

  set usuario(String usuario) {
    try {
      _prefs.setString('usuario', usuario);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  String get usuarioFirebase {
    try {
      return _prefs.getString('usuarioFirebase') ?? '';
    } catch (e) {
      return '';
    }
  }

  set usuarioFirebase(String usuarioFirebase) {
    try {
      _prefs.setString('usuarioFirebase', usuarioFirebase);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  String get password {
    try {
      return _prefs.getString('password') ?? '';
    } catch (e) {
      return '';
    }
  }

  set password(String password) {
    try {
      _prefs.setString('password', password);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  String get isLoggedIn {
    try {
      return _prefs.getString('isLoggedIn') ?? 'N';
    } catch (e) {
      return 'N';
    }
  }

  set isLoggedIn(String isLoggedIn) {
    try {
      _prefs.setString('isLoggedIn', isLoggedIn);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  String get expiracionToken {
    try {
      return _prefs.getString('expiracionToken') ?? '';
    } catch (e) {
      return '';
    }
  }

  set expiracionToken(String expiracionToken) {
    try {
      _prefs.setString('expiracionToken', expiracionToken);
    } catch (e) {
      debugPrint('Error al guardar la expiracion del token');
    }
  }

  String get fechaExpiracion {
    try {
      return _prefs.getString('fechaExpiracion') ?? '';
    } catch (e) {
      return '';
    }
  }

  set fechaExpiracion(String fechaExpiracion) {
    try {
      _prefs.setString('fechaExpiracion', fechaExpiracion);
    } catch (e) {
      debugPrint('Error al guardar la fecha de expiracion');
    }
  }
}
