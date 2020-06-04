import 'package:flutter/material.dart';

import 'event_detail_page.dart';

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Events',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: EventDetailPage()
    );
  }
}
