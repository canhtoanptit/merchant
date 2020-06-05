import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merchant/helpers/firestore_helper.dart';
import 'package:merchant/models/event_detail_model.dart';
import 'package:merchant/models/favorite_model.dart';
import 'package:merchant/pages/login_page.dart';
import 'package:merchant/shared/authentication.dart';

class EventDetailPage extends StatelessWidget {
  final Authentication auth = new Authentication();
  final String uid;

  EventDetailPage(this.uid);

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
              auth.signOut().then((value) => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage())));
            },
          )
        ],
      ),
      body: EventList(uid),
    );
  }
}

class EventList extends StatefulWidget {
  final String uid;

  EventList(this.uid);

  @override
  _EventListState createState() {
    return _EventListState(uid);
  }
}

class _EventListState extends State<EventList> {
  final Firestore _firestore = Firestore.instance;
  List<EventDetail> details = [];
  final String uid;
  List<Favorite> favs = [];

  _EventListState(this.uid);

  @override
  void initState() {
    if (mounted) {
      FireStoreHelper.getUserFavourites(uid).then((value) {
        setState(() {
          favs = value;
        });
      });
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
            'Date: ${details[position].date} - Start: ${details[position].startTime} - End: ${details[position].endTime}';
        return ListTile(
          title: Text(details[position].description),
          subtitle: Text(sub),
          trailing: IconButton(
            icon: Icon(Icons.star,
                color: isUserFavourite(details[position].id)
                    ? Colors.amber
                    : Colors.grey),
            onPressed: () => toggleFavourite(details[position]),
          ),
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

  void toggleFavourite(EventDetail eventDetail) async {
    if (isUserFavourite(eventDetail.id)) {
      await FireStoreHelper.deleteFavourite(
          favs.firstWhere((element) => element.eventId == eventDetail.id).id);
    } else {
      FireStoreHelper.addFavorite(eventDetail, this.uid);
    }
    List<Favorite> updatedFavourites =
        await FireStoreHelper.getUserFavourites(uid);
    setState(() {
      favs = updatedFavourites;
    });
  }

  bool isUserFavourite(String eventId) {
    return favs.firstWhere((element) => element.eventId == eventId,
            orElse: () => null) !=
        null;
  }
}
