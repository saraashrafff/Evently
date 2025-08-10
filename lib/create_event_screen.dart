import 'package:evently/app_theme.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/ui_utils.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  TextEditingController describtionController = TextEditingController();
  CategoryModel selectedCategory = CategoryModel.categories.first;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('d/M/yyyy');
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.createEvent)),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/${selectedCategory.imageName}.png',
                    height: MediaQuery.sizeOf(context).height * 0.23,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              DefaultTabController(
                length: CategoryModel.categories.length,
                child: TabBar(
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.only(left: 16),
                  onTap: (index) {
                    if (currentIndex == index) return;
                    currentIndex = index;
                    selectedCategory = CategoryModel.categories[currentIndex];
                    setState(() {});
                  },
                  tabs: CategoryModel.categories
                      .map(
                        (category) => TabItem(
                          label: category.name,
                          icon: category.icon,
                          isSelected:
                              CategoryModel.categories.indexOf(category) ==
                              currentIndex,
                          selectedForegroundColor: settingsProvider.isDark
                              ? AppTheme.backgroundDark
                              : AppTheme.white,
                          unSelectedForegroundColor: AppTheme.primary,
                          selectedBackgroundColor: AppTheme.primary,
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: textTheme.titleMedium,
                    ),
                    SizedBox(height: 8),
                    DefaultTextFormField(
                      hintText: AppLocalizations.of(context)!.eventTitle,
                      prefixIconImageName: 'title',
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.titleCannotBeEmpty;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.description,
                      style: textTheme.titleMedium,
                    ),
                    SizedBox(height: 8),
                    DefaultTextFormField(
                      hintText: AppLocalizations.of(context)!.eventDescription,
                      controller: describtionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.descripitionCannotBeEmpty;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/date.svg',
                          colorFilter: ColorFilter.mode(
                            settingsProvider.isDark
                                ? AppTheme.white
                                : AppTheme.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.eventDate,
                          style: textTheme.titleMedium,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 365)),
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                            );
                            if (date != null) {
                              selectedDate = date;
                              setState(() {});
                            }
                          },
                          child: Text(
                            selectedDate == null
                                ? AppLocalizations.of(context)!.selectDate
                                : dateFormat.format(selectedDate!),
                            style: textTheme.titleMedium!.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/time.svg',
                          colorFilter: ColorFilter.mode(
                            settingsProvider.isDark
                                ? AppTheme.white
                                : AppTheme.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.eventTime,
                          style: textTheme.titleMedium,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () async {
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (time != null) {
                              selectedTime = time;
                              setState(() {});
                            }
                          },
                          child: Text(
                            selectedTime == null
                                ? AppLocalizations.of(context)!.selectTime
                                : selectedTime!.format(context),
                            style: textTheme.titleMedium!.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    DefaultElevatedButton(
                      label: AppLocalizations.of(context)!.addevent,
                      onPressed: createEvent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
        description: describtionController.text,
        dateTime: dateTime,
      );
      FirebaseService.creatEvent(event)
          .then((_) {
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
