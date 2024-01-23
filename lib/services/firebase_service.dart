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
      "nroChip": data["nroChip"],
      "madre": data["madre"],
      "padre": data["padre"],
      "receptora": data["receptora"],
      "fechaNac": data["fechaNac"],
      "centroEmb": data["centroEmb"],
      "lstImagenes": data["lstImagenes"],
      "uid": doc.id
    };
    horses.add(horse);
  }

  return horses;
}

Future<dynamic> getHorseByUid(String uid) async {
  CollectionReference collectionReferenceHorses = db.collection('horses');

  QuerySnapshot queryHorses = await collectionReferenceHorses.get();
  var horse = {};
  for (var doc in queryHorses.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    horse = {
      "name": data["name"],
      "nroChip": data["nroChip"],
      "madre": data["madre"],
      "padre": data["padre"],
      "receptora": data["receptora"],
      "fechaNac": data["fechaNac"],
      "centroEmb": data["centroEmb"],
      "lstImagenes": data["lstImagenes"],
      "uid": doc.id
    };
  }
  return horse;
}

Future<void> addHorse(
  String name,
  String nroChip,
  String madre,
  String padre,
  String receptora,
  String fechaNac,
  String centroEmb,
  List<String> lstImagenes,
) async {
  await db.collection('horses').add({
    "name": name,
    "nroChip": nroChip,
    "madre": madre,
    "padre": padre,
    "receptora": receptora,
    "fechaNac": fechaNac,
    "centroEmb": centroEmb,
    "lstImagenes": lstImagenes
  });
  //Firestore.instance.collection('users').document(uid).updateData({ 'name': name, 'surname': surname, 'address': address, 'level': level.toJson() });
}

Future<void> updateHorse(
  String uid,
  String name,
  String nroChip,
  String madre,
  String padre,
  String receptora,
  String fechaNac,
  String centroEmb,
  List<String> lstImagenes,
) async {
  await db.collection('horses').doc(uid).set({
    "name": name,
    "nroChip": nroChip,
    "madre": madre,
    "padre": padre,
    "receptora": receptora,
    "fechaNac": fechaNac,
    "centroEmb": centroEmb,
    "lstImagenes": lstImagenes
  });
}

Future<void> deleteHorse(String uid) async {
  await db.collection('horses').doc(uid).delete();
}

Future<List<dynamic>> filterHorsesByName(String name) async {
  List<dynamic> allHorses = await getHorses();
  if (name.isEmpty) {
    return allHorses;
  }
  return allHorses
      .where((horse) => horse['name'].toLowerCase().contains(name.toLowerCase()) || horse['nroChip'].toLowerCase().contains(name.toLowerCase()))
      .toList();
}

Future<String>? getItemDescription(String label, String? itemUid, Future<List<dynamic>> lstItem) async {
  if (itemUid == null) return '';
  var item = await lstItem.then((items) => items.firstWhere((item) => item['uid'] == itemUid, orElse: () => {}));
  return item[label] ?? 'Seleccione una opcion';
}

Future<String>? getMadreDescription(String label, String? madreUid, Future<List<dynamic>> lstMadres) async {
  if (madreUid == null) return '';
  var madre = await lstMadres.then((madres) => madres.firstWhere((madre) => madre['uid'] == madreUid, orElse: () => {}));
  return madre['madre'];
}

Future<String>? getPadreDescription(String? padreUid, Future<List<dynamic>> lstPadres) async {
  if (padreUid == null) return '';
  var padre = await lstPadres.then((padres) => padres.firstWhere((padre) => padre['uid'] == padreUid, orElse: () => {}));
  return padre['padre'];
}

Future<String>? getReceptoraDescription(String? receptoraUid, Future<List<dynamic>> lstReceptoras) async {
  if (receptoraUid == null) return '';
  var receptora = await lstReceptoras.then((padres) => padres.firstWhere((receptora) => receptora['uid'] == receptoraUid, orElse: () => {}));
  return receptora['receptora'];
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
