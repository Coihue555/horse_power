import 'package:horse_power/data/cloud/cloud_mvc_db.dart';
import 'package:horse_power/global/environment.dart';
import 'package:horse_power/models/coleccion_mvc_model.dart';

class MvcDb<T extends ColeccionMvc> {
  final CloudMvcDb cloudMvcDb;
  final T modelo;

  MvcDb({required this.cloudMvcDb, required this.modelo});

  /// `paramentros` - Unico parametro requirido es `consultaCloud` donde un valor
  /// de ejemplo correcto seria: Localidad.json?orderBy="CreadoEl"&startAt="20220101102322"'
  /// `modelo` - Es el modelo de la coleccion que se esta consultando
  /// `argsIsar` Args es del siguiente tipo
  /// `[[indexNames][operador][values]]` donde la seccion `0` es
  /// `operador` la `1` es `where` y la `2` es `whereArgs`
  /// `utilizaISar` - Es un booleano que determina si se utiliza ISar o no para
  /// esta consulta en particular si es `null` se utiliza el valor por defecto
  /// que tiene establcido MvcDb
  Future<Map<String, dynamic>> obtener({
    Map<String, String>? headers,
    Object? body,
    required String consultaCloud,
    String? limit,
    String? skip,
  }) async {
    try {
      final response = await cloudMvcDb.obtener(headers: headers, body: body, consulta: consultaCloud, modelo: modelo);
      if (response.containsKey(Environment.dataOk)) {
        final List<T> items = [...response[Environment.dataOk]];

        return {Environment.dataOk: items};
      }
      return response;
    } catch (error) {
      return {Environment.dataNOk: error.toString()};
    }
  }

  ///Funcion utilizada para leer un solo registro require como parametro
  ///`coleccion` - Es la coleccion que se envia al Servidor ejemplo tablaHistorialVacunados
  ///`key` - Es el id del registro que se esta consultando
  ///la respuesta es un solo registro siempre
  Future<Map<String, dynamic>> leeById({Map<String, String>? headers, Object? body, required String coleccion, required String key}) async {
    try {
      final response = await cloudMvcDb.leeById(headers: headers, body: body, coleccion: coleccion, key: key, modelo: modelo);
      if (response.containsKey(Environment.dataOk)) {
        final T item = response[Environment.dataOk];

        return {Environment.dataOk: item};
      }
      return response;
    } catch (error) {
      return {Environment.dataNOk: error.toString()};
    }
  }

  /// `data` - Es el modelo de la coleccion que se esta enviando al Servidor
  /// `consulta` - Es la coleccion que se envia al Servidor ejemplo tablaHistorialVacunados.json/
  Future<Map<String, dynamic>> guardar({required T data, required consulta}) async {
    try {
      ///Con esta pregunta se determina si se guarda en el servidor primero y
      ///si la respuesta esta OK ahi guardo en el dispositivo

      if (data.idMVC.isNotEmpty) {
        throw 'Actualizacion no permitida';
      }
      final body = data.registroToJson(data: data);
      final response = await cloudMvcDb.enviar(consulta: consulta, body: body);
      if (response.containsKey(Environment.dataOk)) {
        data = data.copyWith(idMVC: response[Environment.dataOk]);

        return {Environment.dataOk: data};
      }
      return response;
    } catch (error) {
      return {Environment.dataNOk: error.toString()};
    }
  }
}
