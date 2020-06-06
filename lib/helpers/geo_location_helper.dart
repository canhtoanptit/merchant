import 'package:geolocator/geolocator.dart';

class GeoLocationHelper {
  static Future<Position> getCurrentLocation(double latitude, double longitude) async {
    bool isGeolocationAvailable = await Geolocator().isLocationServiceEnabled();
    Position _position = Position(latitude: latitude, longitude: longitude);
    if (isGeolocationAvailable) {
      try {
        _position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      } catch (error) {
        return _position;
      }
    }
    return _position;
  }
}
