import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:merchant/helpers/geo_location_helper.dart';

class TreasureMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Treasure map'),
      ),
      body: MainMap(),
    );
  }
}

class MainMap extends StatefulWidget {
  @override
  _MainMapState createState() {
    return _MainMapState();
  }
}

class _MainMapState extends State<MainMap> {
  List<Marker> markers = [];

  final CameraPosition position = CameraPosition(
    target: LatLng(41.9028, 12.4964),
    zoom: 12,
  );

  @override
  void initState() {
    GeoLocationHelper.getCurrentLocation(
            position.target.latitude, position.target.longitude)
        .then((pos) {
      addMarker(pos, 'currpos', 'You are here!');
    }).catchError((err) => print(err.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: position,
      markers: Set<Marker>.of(markers),
    );
  }

  void addMarker(Position pos, String markerId, String markerTitle) {
    final Marker marker = Marker(
        markerId: MarkerId(markerId),
        position: LatLng(pos.latitude, pos.longitude),
        infoWindow: InfoWindow(title: markerTitle),
        icon: (markerId == 'currpos')
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
            : BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange));
    markers.add(marker);
    setState(() {
      markers = markers;
    });
  }
}
