import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:roadcognizer/exception/exception.dart';
import 'package:roadcognizer/exception/user_not_authenticated_exception.dart';
import 'package:roadcognizer/services/firebase/firebase.service.dart';
import 'package:roadcognizer/services/log/log.dart';
import 'package:roadcognizer/util/generate_random.dart';

// full path in Firebase Storage /user_uploads/images/:uid/:image_id
// TODO: move this userUploads to somewhere else if needed
const String _userUploadPrefix = 'userUploads';
const String _imagePrefix = 'images';

String _getContentType(String imagePath) {
  final ext = imagePath.split('.').last;
  switch (ext) {
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    case 'png':
    case 'webp':
      // add other web image formats here
      return "image/$ext";
    default:
      return 'application/octet-stream';
  }
}

/// Uploads an image to Firebase Storage.
///
/// Returns the download URL of the uploaded image.
Future<String> uploadImage(String imagePath, [bool isSleep = false]) async {
  log.d('Uploading image: $imagePath');

  if (isSleep) {
    await Future.delayed(const Duration(seconds: 10));
    return Future.error(UploadImageException('Error uploading image'));
  }

  final storage = FirebaseService.storage;
  final userCred = FirebaseService.userCredential;

  final uid = userCred.user?.uid;

  if (uid == null) {
    return Future.error(
        UserNotAuthenticatedException('User not authenticated'));
  }

  final ref = storage.ref(_userUploadPrefix).child(_imagePrefix);
  final imageRef = ref.child(uid).child(
        '${getRandomString(10)}.${basename(imagePath).split('.').last}',
      );
  final uploadTask = imageRef.putFile(
      File(imagePath),
      SettableMetadata(
        contentType: _getContentType(imagePath),
      ));

  try {
    await uploadTask;
    return await imageRef.getDownloadURL();
  } on FirebaseException catch (e) {
    return Future.error(UploadImageException('Error uploading image: $e'));
  }
}
