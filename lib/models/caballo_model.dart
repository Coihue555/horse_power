class HorseModel {
  String name;
  List<String> lstImages;

  HorseModel({required this.name, required this.lstImages});

  // Factory method to create a HorseModel from a JSON map
  factory HorseModel.fromJson(Map<String, dynamic> json) {
    return HorseModel(
      name: json['name'],
      lstImages: List<String>.from(json['lstImages']),
    );
  }

  // Method to convert HorseModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lstImages': lstImages,
    };
  }
}
