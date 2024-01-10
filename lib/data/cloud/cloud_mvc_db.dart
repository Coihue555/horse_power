import 'dart:convert';

import 'package:horse_power/data/data/shp.dart';
import 'package:horse_power/global/environment.dart';
import 'package:horse_power/models/coleccion_mvc_model.dart';
import 'package:horse_power/provider/http/httpprovider.dart';

class CloudMvcDb<T extends ColeccionMvc> {
  final HttpProvider httpProvider;
  final Shp shp;

  CloudMvcDb({required this.httpProvider, required this.shp});

  /// `paramentros` - Unico parametro requirido es `consulta` donde un valor
  /// de ejemplo correcto seria: Localidad.json?orderBy="CreadoEl"&startAt="20220101102322"'
  /// `modelo` - Es el modelo de la coleccion que se esta consultando
  Future<Map<String, dynamic>> obtener({Map<String, String>? headers, Object? body, required String consulta, required T modelo}) async {
    try {
      final endPoint = '${'octarineflcrud.appspot.com'}/$consulta';
      int intentos = 0;
      Map<String, dynamic> response = {};
      do {
        response = await httpProvider.httpAccion('GET', endPoint, headers: headers, body: body);
        if (response.containsKey(Environment.dataOk)) {
          final List<T> items = [];
          try {
            final jsonResponse = json.decode(response[Environment.dataOk]);
            if (jsonResponse == null) {
              ///Esto solo surge si la coleccion aun no fue creado
              return {Environment.dataOk: items};
            }

            jsonResponse.forEach((key, value) {
              value.putIfAbsent(Environment.literarIdColeccionIsar, () => key);
              items.add(modelo.fromJson(value));
            });
          } catch (error) {
            return {Environment.dataNOk: error.toString()};
          }
          return {Environment.dataOk: items};
        }
        intentos++;
      } while (intentos <= 1);
      return response;
    } catch (error) {
      return {Environment.dataNOk: error.toString()};
    }
  }

  Future<Map<String, dynamic>> leeById({Map<String, String>? headers, Object? body, required String coleccion, required String key, required T modelo}) async {
    try {
      final endPoint = '${'octarineflcrud.appspot.com'}/$coleccion/$key.json';
      int intentos = 0;
      Map<String, dynamic> response = {};
      do {
        response = await httpProvider.httpAccion('GET', endPoint, headers: headers, body: body);
        if (response.containsKey(Environment.dataOk)) {
          final T item;
          try {
            final jsonResponse = json.decode(response[Environment.dataOk]);
            jsonResponse[Environment.literarIdColeccionIsar] = key;
            item = modelo.fromJson(jsonResponse);
          } catch (error) {
            return {Environment.dataNOk: error.toString()};
          }
          return {Environment.dataOk: item};
        }
        intentos++;
      } while (intentos <= 1);
      return response;
    } catch (error) {
      return {Environment.dataNOk: error.toString()};
    }
  }

  Future<Map<String, dynamic>> enviar({Map<String, String>? headers, Object? body, required String consulta}) async {
    try {
      final endPoint = '${'octarineflcrud.appspot.com'}/$consulta';
      int intentos = 0;
      Map<String, dynamic> response = {};
      do {
        response = await httpProvider.httpAccion('POST', endPoint, headers: headers, body: body);
        if (response.containsKey(Environment.dataOk)) {
          final jsonResponse = jsonDecode(response[Environment.dataOk]);
          final idFirebase = jsonResponse.containsKey('name') ? jsonResponse['name'] : '';
          if (idFirebase.isNotEmpty) {
            return {Environment.dataOk: idFirebase};
          } else {
            return {Environment.dataNOk: 'No se obtuvo el idFirebase'};
          }
        }
        intentos++;
      } while (intentos <= 1);
      return response;
    } catch (error) {
      return {Environment.dataNOk: error.toString()};
    }
  }

  Future<Map<String, dynamic>> actualizar({Map<String, String>? headers, Object? body, required String consulta, required T modelo}) async {
    try {
      final endPoint = '${'octarineflcrud.appspot.com'}/$consulta';
      int intentos = 0;
      Map<String, dynamic> response = {};
      do {
        response = await httpProvider.httpAccion('PUT', endPoint, headers: headers, body: body);
        if (response.containsKey(Environment.dataOk)) {
          final T item;
          try {
            final jsonResponse = json.decode(response[Environment.dataOk]);
            jsonResponse[Environment.literarIdColeccionIsar] = modelo.idMVC;
            item = modelo.fromJson(jsonResponse);
          } catch (error) {
            return {Environment.dataNOk: error.toString()};
          }
          return {Environment.dataOk: item};
        }
        intentos++;
      } while (intentos <= 1);
      return response;
    } catch (error) {
      return {Environment.dataNOk: error.toString()};
    }
  }

  Future<Map<String, dynamic>> loginFirebase({required String usuario, required String password}) async {
    try {
      final body = json.encode({
        'email': usuario,
        'password': password,
        'returnSecureToken': true,
      });
      const endPoint = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyB9tWtTDcvyHDnBT62LHJE91RHlWawFWPI';
      int intentos = 0;
      Map<String, dynamic> response = {};
      do {
        response = await httpProvider.httpAccion('POST', endPoint, body: body);
        if (response.containsKey(Environment.dataOk)) {
          return response;
        }
        intentos++;
      } while (intentos <= 1);
      if (response.containsKey(Environment.dataNOk)) {
        if (response.containsKey(Environment.status)) {
          if (response[Environment.status] == '400') {
            return {Environment.dataNOk: 'Usuario o contraseña incorrectos, intente nuevamente'};
          }
        }
        if (response[Environment.dataNOk] == 'Sin conexión a Internet' && shp.tokenFirebase != '') {
          return {Environment.dataOk: '{"idToken": ${shp.tokenFirebase}, "offline": true}'};
        }
      }
      return response;
    } catch (error) {
      return {Environment.dataNOk: error.toString()};
    }
  }

  ///Todo esto se debe cambiar por env despues
  Future<Map<String, dynamic>> nuevoUsuario({required String usuario, required String password}) async {
    try {
      final body = json.encode({
        'email': usuario,
        'password': password,
      });
      const endPoint = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBqf9JDqaKnTHzleFEpbjbCoYKMmRpr9kc';
      int intentos = 0;
      Map<String, dynamic> response = {};
      do {
        response = await httpProvider.httpAccion('POST', endPoint, body: body);
        if (response.containsKey(Environment.dataOk)) {
          return response;
        }
        intentos++;
      } while (intentos <= 1);
      if (response.containsKey(Environment.dataNOk)) {
        return response;
      }
      return response;
    } catch (error) {
      return {Environment.dataNOk: error.toString()};
    }
  }
}
