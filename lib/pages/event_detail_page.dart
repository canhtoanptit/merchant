import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merchant/models/event_detail_model.dart';
import 'package:merchant/pages/login_page.dart';
import 'package:merchant/shared/authentication.dart';

class EventDetailPage extends StatelessWidget {

  Authentication auth = new Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              auth.signOut().then((value) =>
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LoginPage()
                  )));
            },
          )
        ],
      ),
      body: EventList(),
    );
  }
}

class EventList extends StatefulWidget {
  @override
  _EventListState createState() {
    return _EventListState();
  }
}

class _EventListState extends State<EventList> {
  final Firestore _firestore = Firestore.instance;
  List<EventDetail> details = [];

  @override
  void initState() {
    if (mounted) {
      getDetailsList().then((value) {
        setState(() {
          details = value;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, position) {
        String sub =
            'Date: ${details[position].date} - Start: ${details[position]
            .startTime} - End: ${details[position].endTime}';
        return ListTile(
          title: Text(details[position].description),
          subtitle: Text(sub),
        );
      },
      itemCount: details != null ? details.length : 0,
    );
  }

  Future<List<EventDetail>> getDetailsList() async {
    var data = await _firestore.collection('event_details').getDocuments();
    if (data != null) {
      details = data.documents
          .map((document) => EventDetail.fromMap(document))
          .toList();
      int i = 0;
      details.forEach((element) {
        element.id = data.documents[i].documentID;
        i++;
      });
    }
    return details;
  }
}
