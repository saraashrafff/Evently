import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_model.dart';

class FirebaseService {
  static CollectionReference<EventModel> getEventsCollections() =>
      FirebaseFirestore.instance
          .collection('events')
          .withConverter(
            fromFirestore: (docSnapshot, _) =>
                EventModel.fromJson(docSnapshot.data()!),
            toFirestore: (event, _) => event.toJson(),
          );
  static Future<void> creatEvent(EventModel event) {
    CollectionReference<EventModel> eventCollections = getEventsCollections();
    DocumentReference<EventModel> doc = eventCollections.doc();
    event.id = doc.id;
    return doc.set(event);
  }
}
