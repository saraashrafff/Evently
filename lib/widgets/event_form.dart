import 'package:evently/app_theme.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventForm extends StatefulWidget {
  final String appBarTitle;
  final String buttonLabel;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  CategoryModel selectedCategory;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final GlobalKey<FormState> formKey;
  final void Function(CategoryModel) onCategoryChanged;
  final void Function(DateTime) onDateChanged;
  final void Function(TimeOfDay) onTimeChanged;
  final VoidCallback onSubmit;

  EventForm({
    required this.appBarTitle,
    required this.buttonLabel,
    required this.titleController,
    required this.descriptionController,
    required this.selectedCategory,
    required this.selectedDate,
    required this.selectedTime,
    required this.formKey,
    required this.onCategoryChanged,
    required this.onDateChanged,
    required this.onTimeChanged,
    required this.onSubmit,
  });

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  int currentIndex = 0;

  DateFormat dateFormat = DateFormat('d/M/yyyy');
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.appBarTitle)),
      body: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/${widget.selectedCategory.imageName}.png',
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
                    widget.selectedCategory =
                        CategoryModel.categories[currentIndex];
                    widget.onCategoryChanged(
                      CategoryModel.categories[currentIndex],
                    );
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
                      controller: widget.titleController,
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
                      controller: widget.descriptionController,
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
                              widget.selectedDate = date;
                              widget.onDateChanged(date);
                              setState(() {});
                            }
                          },
                          child: Text(
                            widget.selectedDate == null
                                ? AppLocalizations.of(context)!.selectDate
                                : dateFormat.format(widget.selectedDate!),
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
                              widget.selectedTime = time;
                              widget.onTimeChanged(time);
                              setState(() {});
                            }
                          },
                          child: Text(
                            widget.selectedTime == null
                                ? AppLocalizations.of(context)!.selectTime
                                : widget.selectedTime!.format(context),
                            style: textTheme.titleMedium!.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    DefaultElevatedButton(
                      label: widget.buttonLabel,
                      onPressed: widget.onSubmit,
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
}
