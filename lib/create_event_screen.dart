import 'package:evently/firebase_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/ui_utils.dart';
import 'package:evently/widgets/event_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = '/create-event';

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int currentIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CategoryModel selectedCategory = CategoryModel.categories.first;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('d/M/yyyy');
  @override
  Widget build(BuildContext context) {
    Provider.of<SettingsProvider>(context);
    return EventForm(
      appBarTitle: AppLocalizations.of(context)!.createEvent,
      buttonLabel: AppLocalizations.of(context)!.createEvent,
      titleController: titleController,
      descriptionController: descriptionController,
      selectedCategory: selectedCategory,
      selectedDate: selectedDate,
      selectedTime: selectedTime,
      formKey: formkey,
      onCategoryChanged: (category) {
        setState(() {
          selectedCategory = category;
        });
      },
      onDateChanged: (date) {
        setState(() {
          selectedDate = date;
        });
      },
      onTimeChanged: (time) {
        setState(() {
          selectedTime = time;
        });
      },
      onSubmit: createEvent,
    );
  }

  void createEvent() {
    if (formkey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      DateTime dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      EventModel event = EventModel(
        userId: FirebaseAuth.instance.currentUser!.uid,
        category: selectedCategory,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: dateTime,
      );
      FirebaseService.creatEvent(event)
          .then((_) {
            Provider.of<EventProvider>(context, listen: false).addEvent(event);
            Navigator.of(context).pop();
            UIUtils.showSuccessMessege(
              AppLocalizations.of(context)!.eventCreatedSuccessfully,
            );
          })
          .catchError((_) {
            UIUtils.showErrorMessege(
              AppLocalizations.of(context)!.failedToCreateEvent,
            );
          });
    }
  }
}
