import 'package:evently/firebase_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/ui_utils.dart';
import 'package:evently/widgets/event_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditEventScreen extends StatefulWidget {
  static const routeName = '/edit-event';

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late EventModel event;

  late int currentIndex;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late CategoryModel selectedCategory;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('d/M/yyyy');
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (!_isInitialized) {
        final args = ModalRoute.of(context)?.settings.arguments;
        if (args is EventModel) {
          event = args;
          titleController.text = event.title;
          descriptionController.text = event.description;
          selectedCategory = event.category;
          selectedDate = event.dateTime;
          selectedTime = TimeOfDay(
            hour: event.dateTime.hour,
            minute: event.dateTime.minute,
          );
          currentIndex = CategoryModel.categories.indexWhere(
            (category) => category.id == selectedCategory.id,
          );

          setState(() {
            _isInitialized = true;
          });
        }
      }
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return EventForm(
      appBarTitle: AppLocalizations.of(context)!.editEvent,
      buttonLabel: AppLocalizations.of(context)!.updateEvent,
      titleController: titleController,
      descriptionController: descriptionController,
      selectedCategory: selectedCategory,
      selectedDate: selectedDate,
      selectedTime: selectedTime,
      currentIndex: currentIndex,
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
      onSubmit: updateEvent,
    );
  }

  void updateEvent() {
    if (formkey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      DateTime updatedDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      event.title = titleController.text;
      event.description = descriptionController.text;
      event.category = selectedCategory;
      event.dateTime = updatedDateTime;

      FirebaseService.updateEvent(event)
          .then((_) {
            Navigator.of(context).pop();
            UIUtils.showSuccessMessege(
              AppLocalizations.of(context)!.eventUpdatedSuccessfully,
            );
          })
          .catchError((_) {
            UIUtils.showErrorMessege(
              AppLocalizations.of(context)!.failedToUpdateEvent,
            );
          });
    }
  }
}
