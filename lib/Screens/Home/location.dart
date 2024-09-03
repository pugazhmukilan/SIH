import 'package:geolocator/geolocator.dart';

Future<Map<String, double>> getCurrentLocation() async {
  try {
    // Request location permission
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    
    // Return latitude and longitude
    return {
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
  } catch (e) {
    print('Error getting location: $e');
    return {
      'latitude': 0.0,
      'longitude': 0.0,
    };
  }
}