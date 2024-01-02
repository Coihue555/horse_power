abstract class ColeccionMvc<T> {
  final int? id;
  final String idMVC; //Id Cloud

  final Map<String, dynamic> data;
  final String creadoEl;

  ColeccionMvc({
    this.id,
    required this.idMVC,
    required this.data,
    required this.creadoEl,
  });

  Map<String, dynamic> toJson();

  T fromJson(Map<String, dynamic> json);

  String registroToJson({T? data});

  T copyWith({
    int? id,
    String? idMVC,
    Map<String, dynamic>? data,
    String? creadoEl,
  });
}
