import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roadcognizer/models/traffic_sign_image/traffic_sign_image.dart';
import 'package:roadcognizer/models/roadcognizer_user/roadcognizer_user.dart';
import 'package:roadcognizer/services/firebase/firebase.service.dart';

class UserService {
  static const collectionName = 'users';
  final db = FirebaseService.firestore;

  late final CollectionReference<RoadcognizerUser> _users;

  UserService() {
    _users = db.collection(collectionName).withConverter<RoadcognizerUser>(
          fromFirestore: (json, _) => RoadcognizerUser.fromJson(json.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  Future<void> createUser(RoadcognizerUser user) async {
    await _users.doc(user.uid).set(user);
  }

  Future<RoadcognizerUser?> getUser(String uid) async {
    final user = await getUserRef(uid).get();
    return user.data();
  }

  DocumentReference<RoadcognizerUser> getUserRef(String uid) {
    return _users.doc(uid);
  }

  Future<RoadcognizerUser> getCurrentUser() async {
    final user = FirebaseService.auth.currentUser;
    if (user == null) {
      throw Exception("User is not logged in");
    }

    return getUser(user.uid).then((value) {
      if (value == null) {
        throw Exception("User not found");
      }

      return value;
    });
  }

  Future<List<RoadcognizerUser>> getUsers() async {
    final users = await _users.get();
    return users.docs.map((doc) => doc.data()).toList();
  }

  Future<bool> exist(String uid) async {
    final user = await _users.doc(uid).get();
    return user.exists;
  }

  Future<void> createUserIfNotExist(RoadcognizerUser user) async {
    if (!await exist(user.uid)) {
      await createUser(user);
    }
  }

  CollectionReference<Map<String, dynamic>> getUserImagesRef(String uid) {
    return getUserRef(uid).collection("images");
  }

  CollectionReference<TrafficSignImage> getCurrentUserImagesRef() {
    final uid = FirebaseService.auth.currentUser?.uid;
    if (uid == null) {
      throw Exception("User is not logged in");
    }

    return getUserImagesRef(uid).withConverter<TrafficSignImage>(
      fromFirestore: (json, _) => TrafficSignImage.fromJson(json.data()!),
      toFirestore: (image, _) => image.toJson(),
    );
  }

  Future<List<TrafficSignImage>> getCurrentUserImages() async {
    return await getCurrentUserImagesRef().get().then(
          (images) => images.docs.map((doc) => doc.data()).toList(),
        );
  }

  Future<bool> isCurrentUserImageLimitReached() async {
    final images = await getCurrentUserImagesRef()
        .where(
          "createdAt",
          isGreaterThan: Timestamp.fromDate(
            DateTime.now().subtract(
              const Duration(days: 1),
            ),
          ),
        )
        .get()
        .then(
          (images) => images.docs
              .map(
                (doc) => doc.data(),
              )
              .toList(),
        );

    return images.length > 2;
  }

  Future<void> addImageToCurrentUser(TrafficSignImage image) async {
    await getCurrentUserImagesRef().add(image);
  }
}
