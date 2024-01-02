import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:horse_power/models/coleccion_mvc_model.dart';

class ChequeoModel extends Equatable implements ColeccionMvc<ChequeoModel> {
  ChequeoModel({
    this.id,
    this.idMVC = '',
    this.idChequeo = '',
    this.creadoEl = '',
    this.idVeterinario = '',
    this.idHorse = '',
    this.observaciones = '',
    this.estado = 'A',
    this.lstImagenes = const [],
    Map<String, dynamic>? data,
  }) : data = data ?? {};

  @override
  final int? id;
  @override
  final String idMVC;
  @override
  final String creadoEl;
  @override
  final Map<String, dynamic> data;

  final String idChequeo;
  final String idVeterinario;
  final String idHorse;
  final String observaciones;
  final String estado;
  final List<String> lstImagenes;

  @override
  ChequeoModel copyWith({
    int? id,
    String? idMVC,
    String? creadoEl,
    Map<String, dynamic>? data,
  }) =>
      ChequeoModel(
          id: id ?? this.id,
          idMVC: idMVC ?? this.idMVC,
          idHorse: data?['idHorse'] ?? idHorse,
          idVeterinario: data?['idVeterinario'] ?? idVeterinario,
          idChequeo: data?['idChequeo'] ?? idChequeo,
          observaciones: data?['observaciones'] ?? observaciones,
          estado: data?['estado'] ?? estado,
          creadoEl: creadoEl ?? this.creadoEl,
          lstImagenes: [...data?['lstImagenes'] ?? lstImagenes],
          data: data ?? this.data);

  factory ChequeoModel.fromJson(Map<String, dynamic> json) {
    return ChequeoModel(
        idHorse:
            (json.containsKey("idHorse")) ? json["idHorse"].toString() : '',
        idVeterinario: (json.containsKey("idVeterinario"))
            ? json["idVeterinario"].toString()
            : '',
        idChequeo:
            (json.containsKey("idChequeo")) ? json["idChequeo"].toString() : '',
        observaciones: (json.containsKey("observaciones"))
            ? json["observaciones"].toString()
            : '',
        estado: (json.containsKey("estado")) ? json["estado"].toString() : '',
        lstImagenes:
            (json.containsKey("lstImagenes")) ? [...json["lstImagenes"]] : [],
        creadoEl:
            (json.containsKey("creadoEl")) ? json["creadoEl"].toString() : '',
        idMVC: (json.containsKey("idMVC")) ? json["idMVC"].toString() : '',
        data: json);
  }

  @override
  ChequeoModel fromJson(Map<String, dynamic> json) {
    return ChequeoModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => {
        "idMVC": idMVC,
        "idHorse": idHorse,
        "idVeterinario": idVeterinario,
        "idChequeo": idChequeo,
        "observaciones": observaciones,        
        "estado": estado,
        "lstImagenes": lstImagenes,
        "creadoEl": creadoEl,
      };

  Map<String, dynamic> toJsonFormulario() => {
        "idHorse": idHorse,
        "idVeterinario": idVeterinario,
        "idChequeo": idChequeo,
        "observaciones": observaciones,
        "estado": estado,
        "lstImagenes": lstImagenes,
      };
  @override
  String registroToJson({ChequeoModel? data}) {
    ///Aca elimino los campos que son unicamente utilizado por Isar
    /// en el Dispositivo local

    final registro = data?.toJson() ?? toJson();
    registro.remove('idMVC');
    return json.encode(registro);
  }

  @override
  List<Object?> get props => [idHorse, idChequeo, idVeterinario, observaciones, estado, lstImagenes];
}
