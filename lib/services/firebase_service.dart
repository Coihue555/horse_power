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
  List<String> lstImagenes,
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

Future<List> getMadres() async {
  List madres = [];
  CollectionReference collectionReferenceMadres = db.collection('madres');

  QuerySnapshot queryMadres = await collectionReferenceMadres.get();
  for (var doc in queryMadres.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final madre = {"madre": data["madre"], "uid": doc.id};
    madres.add(madre);
  }

  return madres;
}

Future<void> addMadre(
  String madre,
) async {
  await db.collection('madres').add({
    "madre": madre,
  });
}

Future<void> updateMadre(
  String uid,
  String madre,
) async {
  await db.collection('madres').doc(uid).set({
    "madre": madre,
  });
}

Future<void> deleteMadre(String uid) async {
  await db.collection('madres').doc(uid).delete();
}

Future<List> getPadres() async {
  List padres = [];
  CollectionReference collectionReferencePadres = db.collection('padres');

  QuerySnapshot queryPadres = await collectionReferencePadres.get();
  for (var doc in queryPadres.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final padre = {"padre": data["padre"], "uid": doc.id};
    padres.add(padre);
  }

  return padres;
}

Future<void> addPadre(
  String padre,
) async {
  await db.collection('padres').add({
    "padre": padre,
  });
}

Future<void> updatePadre(
  String uid,
  String padre,
) async {
  await db.collection('padres').doc(uid).set({
    "padre": padre,
  });
}

Future<void> deletePadre(String uid) async {
  await db.collection('padres').doc(uid).delete();
}

Future<List> getReceptoras() async {
  List receptoras = [];
  CollectionReference collectionReferenceReceptoras = db.collection('receptoras');

  QuerySnapshot queryReceptoras = await collectionReferenceReceptoras.get();
  for (var doc in queryReceptoras.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final receptora = {"receptora": data["receptora"], "uid": doc.id};
    receptoras.add(receptora);
  }

  return receptoras;
}

Future<void> addReceptora(
  String receptora,
) async {
  await db.collection('receptoras').add({
    "receptora": receptora,
  });
}

Future<void> updateReceptora(
  String uid,
  String receptora,
) async {
  await db.collection('receptoras').doc(uid).set({
    "receptora": receptora,
  });
}

Future<void> deleteReceptora(String uid) async {
  await db.collection('receptoras').doc(uid).delete();
}
