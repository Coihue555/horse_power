class HorseModel {
  int id;
  String name;
  String nroChip;
  String centroEmb;
  String fechaNac;
  String madre;
  String padre;
  String receptora;
  List<String> lstImagenes;

  HorseModel({
    required this.id,
    required this.name,
    required this.nroChip,
    required this.centroEmb,
    required this.fechaNac,
    required this.madre,
    required this.padre,
    required this.receptora,
    required this.lstImagenes,
  });

  // Factory method to create a HorseModel from a JSON map
  factory HorseModel.fromJson(Map<String, dynamic> json) {
    return HorseModel(
      id: json["id"],
      name: json['name'],
      nroChip: json['nroChip'],
      madre: json['madre'],
      padre: json['padre'],
      receptora: json['receptora'],
      fechaNac: json['fechaNac'],
      centroEmb: json['centroEmb'],
      lstImagenes: List<String>.from(json['lstImages']),
    );
  }

  // Method to convert HorseModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nroChip': nroChip,
      'madre': madre,
      'padre': padre,
      'receptora': receptora,
      'fechaNac': fechaNac,
      'centroEmb': centroEmb,
      'lstImagenes': lstImagenes,
    };
  }
}
