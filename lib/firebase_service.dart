import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static CollectionReference<EventModel> getEventsCollections() =>
      FirebaseFirestore.instance
          .collection('events')
          .withConverter(
            fromFirestore: (docSnapshot, _) =>
                EventModel.fromJson(docSnapshot.data()!),
            toFirestore: (event, _) => event.toJson(),
          );
  static CollectionReference<UserModel> getUsersCollections() =>
      FirebaseFirestore.instance
          .collection('users')
          .withConverter(
            fromFirestore: (docSnapshot, _) =>
                UserModel.fromJson(docSnapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );
  static Future<void> creatEvent(EventModel event) {
    CollectionReference<EventModel> eventCollections = getEventsCollections();
    DocumentReference<EventModel> doc = eventCollections.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<List<EventModel>> getEvents() async {
    CollectionReference<EventModel> eventCollections = getEventsCollections();
    QuerySnapshot<EventModel> querySnapshot = await eventCollections
        .orderBy('timestamp')
        .get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user = UserModel(
      id: credential.user!.uid,
      name: name,
      email: email,
      favouriteEventsIds: [],
    );
    CollectionReference<UserModel> usersCollections = getUsersCollections();
    await usersCollections.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    CollectionReference<UserModel> usersCollections = getUsersCollections();
    DocumentSnapshot<UserModel> docSnapShot = await usersCollections
        .doc(credential.user!.uid)
        .get();

    return docSnapShot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();

  static Future<void> addEventsToFavourites(String eventId) async {
    CollectionReference<UserModel> usersCollections = getUsersCollections();
    DocumentReference<UserModel> userDoc = usersCollections.doc(
      FirebaseAuth.instance.currentUser!.uid,
    );
    userDoc.update({
      'favouriteEventsIds': FieldValue.arrayUnion([eventId]),
    });
  }

  static Future<void> removeEventsFromFavourites(String eventId) async {
    CollectionReference<UserModel> usersCollections = getUsersCollections();
    DocumentReference<UserModel> userDoc = usersCollections.doc(
      FirebaseAuth.instance.currentUser!.uid,
    );
    userDoc.update({
      'favouriteEventsIds': FieldValue.arrayRemove([eventId]),
    });
  }
}
