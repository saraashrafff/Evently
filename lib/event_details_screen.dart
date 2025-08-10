import 'package:evently/app_theme.dart';
import 'package:evently/edit_event_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  static const routeName = '/event-details';
  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider = Provider.of<EventProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    EventModel event = ModalRoute.of(context)!.settings.arguments as EventModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamed(EditEventScreen.routeName, arguments: event);
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              eventProvider.removeEvent(event.id);
              FirebaseService.deleteEvent(event)
                  .then((_) {
                    Navigator.of(context).pop();
                    UIUtils.showSuccessMessege(
                      AppLocalizations.of(context)!.eventDeletedSuccessfully,
                    );
                  })
                  .catchError((_) {
                    UIUtils.showErrorMessege(
                      AppLocalizations.of(context)!.failedToDeleteEvent,
                    );
                  });
            },
            icon: Icon(Icons.delete, color: AppTheme.red),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/${event.category.imageName}.png',
                height: MediaQuery.sizeOf(context).height * 0.23,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 16),
            Text(
              event.title,
              style: textTheme.headlineSmall!.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primary),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/date.svg',
                      colorFilter: ColorFilter.mode(
                        AppTheme.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('d MMMM yyyy').format(event.dateTime),
                        style: textTheme.titleMedium!.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        DateFormat('h:mm a').format(event.dateTime),
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: Text(
                'Description',
                style: textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: Text(
                event.description,
                style: textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
