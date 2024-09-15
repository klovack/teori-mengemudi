import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roadcognizer/config.constants.dart';
import 'package:roadcognizer/models/traffic_sign_image/traffic_sign_image.dart';
import 'package:roadcognizer/models/roadcognizer_user/roadcognizer_user.dart';
import 'package:roadcognizer/services/firebase/firebase.service.dart';

class UserService {
  static const userCollectionName = CollectionName.users;
  static const imageCollectionName = CollectionName.images;
  final db = FirebaseService.firestore;

  late final CollectionReference<RoadcognizerUser> _users;

  UserService() {
    _users = db
        .collection(userCollectionName.value)
        .withConverter<RoadcognizerUser>(
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
    return getUserRef(uid).collection(imageCollectionName.value);
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

  Future<UserImageLimit> getCurrentUserImageLimit() async {
    final userCredential = FirebaseService.auth.currentUser;

    if (userCredential == null) {
      throw Exception("User is not logged in");
    }

    final isUserVerified =
        userCredential.emailVerified || userCredential.providerData.length > 1;
    final currentUser = await getCurrentUser();
    final isUserPremium = currentUser.premiumUntil != null &&
        currentUser.premiumUntil!.isAfter(DateTime.now());

    final limit = isUserPremium
        ? UserImageLimit.premium
        : isUserVerified
            ? UserImageLimit.verified
            : UserImageLimit.notVerified;

    return limit;
  }

  Future<List<TrafficSignImage>> getCurrentUserImagesForLast(
      [int numOfDay = 1]) async {
    return await getCurrentUserImagesRef()
        .where(
          "createdAt",
          isGreaterThan: Timestamp.fromDate(
            DateTime.now().subtract(
              Duration(days: numOfDay),
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
  }

  Future<bool> isCurrentUserImageLimitReached() async {
    final limit = await getCurrentUserImageLimit();

    final images = await getCurrentUserImagesForLast(1);

    return images.length >= limit.value;
  }

  Future<void> addImageToCurrentUser(TrafficSignImage image) async {
    await getCurrentUserImagesRef().add(image);
  }
}
