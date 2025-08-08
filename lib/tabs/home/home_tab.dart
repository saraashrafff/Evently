import 'package:evently/providers/events_provider.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:evently/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider = Provider.of<EventProvider>(context);
    return Column(
      children: [
        HomeHeader(),
        SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (_, index) =>
                EventItem(eventProvider.displayedEvents[index]),
            separatorBuilder: (_, _) => SizedBox(height: 16),
            itemCount: eventProvider.displayedEvents.length,
          ),
        ),
      ],
    );
  }
}
