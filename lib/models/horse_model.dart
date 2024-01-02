import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:horse_power/models/coleccion_mvc_model.dart';

class HorseModel extends Equatable implements ColeccionMvc<HorseModel> {
  HorseModel({
    this.id,
    this.idMVC = '',
    this.idItem = '',
    this.creadoEl = '',
    this.horseName = '',
    this.birthDate = '',
    this.idMother = '',
    this.idFather = '',
    this.idReceivingMother = '',
    this.estado = 'A',
    this.lstImagenes = const [],
    Map<String, dynamic>? data,
  }) : data = data ?? {};

  @override
  final int? id;

  @override
  final String idMVC;

  ///Id definido por el usuario
  final String idItem;
  final String horseName;
  final String birthDate;
  final String idMother;
  final String idFather;
  final String idReceivingMother;
  final List<String> lstImagenes;
  final String estado;

  @override
  final String creadoEl;
  @override
  final Map<String, dynamic> data;

  @override
  HorseModel copyWith({
    int? id,
    String? idMVC,
    Map<String, dynamic>? data,
    String? creadoEl,
  }) =>
      HorseModel(
          id: id ?? this.id,
          idMVC: idMVC ?? this.idMVC,
          idItem: data?['idItem'] ?? idItem,
          horseName: data?['horseName'] ?? horseName,
          estado: data?['estado'] ?? estado,
          creadoEl: creadoEl ?? this.creadoEl,
          lstImagenes: [...data?['lstImagenes'] ?? lstImagenes],
          data: data ?? this.data);

  factory HorseModel.fromJson(Map<String, dynamic> json) {
    return HorseModel(
        idItem: (json.containsKey("idItem")) ? json["idItem"].toString() : '',
        horseName: (json.containsKey("horseName")) ? json["horseName"].toString() : '',
        estado: (json.containsKey("estado")) ? json["estado"].toString() : '',
        lstImagenes: (json.containsKey("lstImagenes")) ? [...json["lstImagenes"]] : [],
        creadoEl: (json.containsKey("creadoEl")) ? json["creadoEl"].toString() : '',
        idMVC: (json.containsKey("idMVC")) ? json["idMVC"].toString() : '',
        data: json);
  }

  @override
  HorseModel fromJson(Map<String, dynamic> json) {
    return HorseModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => {
        "idMVC": idMVC,
        "idItem": idItem,
        "horseName": horseName,
        "estado": estado,
        "lstImagenes": lstImagenes,
        "creadoEl": creadoEl,
      };

  Map<String, dynamic> toJsonFormulario() => {
        "idItem": idItem,
        "horseName": horseName,
        "estado": estado,
        "lstImagenes": lstImagenes,
      };
  @override
  String registroToJson({HorseModel? data}) {
    ///Aca elimino los campos que son unicamente utilizado por Isar
    /// en el Dispositivo local

    final registro = data?.toJson() ?? toJson();
    registro.remove('idMVC');
    return json.encode(registro);
  }

  @override
  List<Object?> get props => [idItem, horseName, estado, lstImagenes];
}
