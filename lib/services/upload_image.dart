import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<Map<String, dynamic>> uploadImage(File image) async {
  final String nameFile = image.path.split("/").last;
  final Reference ref = storage.ref().child('images').child(nameFile);
  final UploadTask uploadTask = ref.putFile(image);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  final String url = await snapshot.ref.getDownloadURL();
  log('sdasd: ${image.path}');
  Map<String, dynamic> resp = {};
  if (snapshot.state == TaskState.success) {
    resp = {'Ok': 'ok', "url": url, "path": image.path};
  } else {
    resp = {'NOk': 'NOk', "url": url};
  }
  return resp;
}
