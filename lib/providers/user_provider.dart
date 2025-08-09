import 'package:evently/firebase_service.dart';
import 'package:evently/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;

  void updateCurrentUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }

  bool checkIfFavouriteEvent(String eventId) {
    return currentUser!.favouriteEventsIds.contains(eventId);
  }

  void addEventToFavourite(String eventId) {
    FirebaseService.addEventsToFavourites(eventId);
    currentUser!.favouriteEventsIds.add(eventId);
    notifyListeners();
  }

  void removeEventToFavourite(String eventId) {
    FirebaseService.removeEventsFromFavourites(eventId);
    currentUser!.favouriteEventsIds.remove(eventId);
    notifyListeners();
  }
}
