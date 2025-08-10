import 'package:evently/firebase_service.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {
  List<EventModel> allEvents = [];
  List<EventModel> displayedEvents = [];
  List<EventModel> favouriteEvents = [];

  Future<void> getEvents() async {
    allEvents = await FirebaseService.getEvents();
    displayedEvents = allEvents;
    notifyListeners();
  }

  void filterEvents(CategoryModel? category) {
    if (category == null) {
      displayedEvents = allEvents;
    } else {
      displayedEvents = allEvents
          .where((event) => event.category == category)
          .toList();
    }
    notifyListeners();
  }

  void filterFavouriteEvents(List<String> favouriteIds) {
    favouriteEvents = allEvents
        .where((event) => favouriteIds.contains(event.id))
        .toList();
    notifyListeners();
  }

  void addEvent(EventModel event) {
    allEvents.add(event);
    allEvents.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    displayedEvents = List.from(allEvents);
    notifyListeners();
  }

  void removeEvent(String eventId) {
    allEvents.removeWhere((event) => event.id == eventId);
    displayedEvents.removeWhere((event) => event.id == eventId);
    favouriteEvents.removeWhere((event) => event.id == eventId);
    notifyListeners();
  }
}
