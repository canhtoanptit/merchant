import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite {
  String _id;
  String _eventId;
  String _userId;

  Favorite(this._id, this._eventId, this._userId);

  Favorite.map(DocumentSnapshot documentSnapshot) {
    this._id = documentSnapshot.documentID;
    this._userId = documentSnapshot.data['userId'];
    this._eventId = documentSnapshot.data['eventId'];
  }

  Map<String, dynamic> toMap() {
    Map map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['eventId'] = _eventId;
    map['userId'] = _userId;
    return map;
  }

  String get userId => _userId;

  String get eventId => _eventId;

  String get id => _id;
}
