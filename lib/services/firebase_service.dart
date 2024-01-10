import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getHorses() async {
  List horses = [];
  CollectionReference collectionReferenceHorses = db.collection('horses');

  QuerySnapshot queryHorses = await collectionReferenceHorses.get();
  for (var doc in queryHorses.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final horse = {
      "name": data["name"],
      "madre": data["madre"],
      "padre": data["padre"],
      "receptora": data["receptora"],
      "fechaNac": data["fechaNac"],
      "lstImagenes": data["lstImagenes"],
      "uid": doc.id
    };
    horses.add(horse);
  }

  return horses;
}

Future<void> addHorse(
  String name,
  String madre,
  String padre,
  String receptora,
  String fechaNac,
  List<String> lstImagenes,
) async {
  await db.collection('horses').add({"name": name, "madre": madre, "padre": padre, "receptora": receptora, "fechaNac": fechaNac, "lstImagenes": lstImagenes});
  //Firestore.instance.collection('users').document(uid).updateData({ 'name': name, 'surname': surname, 'address': address, 'level': level.toJson() });
}

Future<void> updateHorse(
  String uid,
  String name,
  String madre,
  String padre,
  String receptora,
  String fechaNac,
  List<dynamic> lstImagenes,
) async {
  await db
      .collection('horses')
      .doc(uid)
      .set({"name": name, "madre": madre, "padre": padre, "receptora": receptora, "fechaNac": fechaNac, "lstImagenes": lstImagenes});
}

Future<void> deleteHorse(String uid) async {
  await db.collection('horses').doc(uid).delete();
}

// /////Testeing HorseModel
// class FirebaseService {
//   final CollectionReference horsesCollection = FirebaseFirestore.instance.collection('horses');

//   Future<void> addHorsee(HorseModel horse) async {
//     try {
//       await horsesCollection.add(horse.toJson());
//     } catch (e) {
//       debugPrint('Error adding horse: $e');
//     }
//   }
// }

// // Example usage:
// void saveHorseToFirebase() {
//   final horse = HorseModel(
//       // Initialize your HorseModel with data
//       );

//   final firebaseService = FirebaseService();
//   firebaseService.addHorsee(horse);
// }
