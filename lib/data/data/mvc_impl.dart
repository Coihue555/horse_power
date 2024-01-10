import 'package:horse_power/data/data/mvc_event.dart';
import 'package:horse_power/global/environment.dart';
import 'package:horse_power/models/coleccion_mvc_model.dart';

import 'mvc_db.dart';

class MvcImpl<T extends ColeccionMvc, E extends MvcDb> implements MvcEvent<T> {
  final E mvcDb;

  MvcImpl({required this.mvcDb});

  /// `paramentros` - Unico parametro requirido es `consultaCloud` donde un valor
  /// de ejemplo correcto seria: Localidad.json?orderBy="CreadoEl"&startAt="20220101102322"'
  /// `argsIsar` es del siguiente tipo
  /// `[[indexNames][operador][values]]` donde la seccion `0` es
  /// `operador` la `1` es `where` y la `2` es `whereArgs`
  @override
  Future<Map<String, dynamic>> obtener({
    Map<String, String>? headers,
    Object? body,
    required String consultaCloud,
    String? limit,
    String? skip,
  }) async {
    try {
      return await mvcDb.obtener(
        headers: headers,
        body: body,
        consultaCloud: consultaCloud,
        limit: limit,
        skip: skip,
      );
    } catch (error) {
      return {Environment.dataNOk: error};
    }
  }

  @override
  Future<Map<String, dynamic>> obtenerUltimoCreadoEl() {
    /// Esta funcion se implementa en cada clase que hereda de MvcImpl
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> obtenerRegistros({required Map<String, dynamic> params}) {
    /// Esta funcion se implementa en cada clase que hereda de MvcImpl
    /// y es utilizada para realizar una consulta especifica
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> leeById({
    Map<String, String>? headers,
    Object? body,
    required String coleccion,
    required String key,
  }) async {
    try {
      return await mvcDb.leeById(
        headers: headers,
        body: body,
        coleccion: coleccion,
        key: key,
      );
    } catch (error) {
      return {Environment.dataNOk: error};
    }
  }

  @override
  Future<Map<String, dynamic>> guardar({required T data, required consulta}) async {
    try {
      return await mvcDb.guardar(data: data, consulta: consulta);
    } catch (error) {
      return {Environment.dataNOk: error};
    }
  }
}
