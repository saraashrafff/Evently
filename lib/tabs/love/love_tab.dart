import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:evently/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoveTab extends StatefulWidget {
  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  late EventProvider eventsProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      List<String> favouriteEventsIds = Provider.of<UserProvider>(
        context,
        listen: false,
      ).currentUser!.favouriteEventsIds;
      eventsProvider.filterFavouriteEvents(favouriteEventsIds);
    });
  }

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    eventsProvider = Provider.of<EventProvider>(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            DefaultTextFormField(
              hintText: 'Search For Event',
              prefixIconImageName: 'search',
              onChanged: (query) {},
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) =>
                    EventItem(eventsProvider.favouriteEvents[index]),
                separatorBuilder: (_, _) => SizedBox(height: 16),
                itemCount: eventsProvider.favouriteEvents.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
