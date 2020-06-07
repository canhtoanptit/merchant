import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant/helpers/db_helper.dart';
import 'package:merchant/models/place_model.dart';

class PlaceDialog {
  final txtName = TextEditingController();
  final txtLat = TextEditingController();
  final txtLon = TextEditingController();
  final bool isNew;
  final Place place;

  PlaceDialog(this.place, this.isNew);

  Widget buildDialog(BuildContext context) {
    DbHelper dbHelper = DbHelper();
    dbHelper.openDb();
    txtName.text = place.name;
    txtLat.text = place.lat.toString();
    txtLon.text = place.lon.toString();

    return AlertDialog(
      title: Text('Crate Place'),
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextField(
              controller: txtName,
              decoration: InputDecoration(
                  hintText: 'Name'
              ),
            ),
            TextField(
              controller: txtLat,
              decoration: InputDecoration(
                  hintText: 'Latitude'
              ),
            ),
            TextField(
              controller: txtLon,
              decoration: InputDecoration(
                  hintText: 'Longitude'
              ),
            ),
            RaisedButton(
              child: Text('OK'),
              onPressed: () {
                place.name = txtName.text;
                place.lat = double.tryParse(txtLat.text);
                place.lon = double.tryParse(txtLon.text);
                dbHelper.insertPlace(place);
                Navigator.pop(context);
              },
            )
          ]),
        )
    );
  }
}
