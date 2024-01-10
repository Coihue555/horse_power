abstract class MvcEvent<T> {
  Future<Map<String, dynamic>> obtener(
      {Map<String, String>? headers,
      Object? body,
      required String consultaCloud,
      String? limit,
      String? skip});
  Future<Map<String, dynamic>> leeById(
      {Map<String, String>? headers,
      Object? body,
      required String coleccion,
      required String key});
  Future<Map<String, dynamic>> guardar({required T data, required consulta});
  Future<Map<String, dynamic>> obtenerUltimoCreadoEl();
  Future<Map<String, dynamic>> obtenerRegistros(
      {required Map<String, dynamic> params});
}
