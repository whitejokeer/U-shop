import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

Future<String> uploadFile(File _image, String carpeta) async {
  StorageReference storageReference = FirebaseStorage.instance
      .ref()
      .child('$carpeta/${Path.basename(_image.path)}}');
  StorageUploadTask uploadTask = storageReference.putFile(_image);
  await uploadTask.onComplete;
  print('File Uploaded');
  String dato;
  await storageReference.getDownloadURL().then((fileURL) {
    dato = fileURL;
  });
  return dato;
}
