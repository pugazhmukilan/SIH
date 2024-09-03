import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class NearbyVeterinariansMap extends StatefulWidget {
  @override
  _NearbyVeterinariansMapState createState() => _NearbyVeterinariansMapState();
}

class _NearbyVeterinariansMapState extends State<NearbyVeterinariansMap> {
  LatLng _currentLocation = LatLng(0.0, 0.0);
  List<Marker> _markers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _addCurrentLocationMarker();
        _loadNearbyVeterinarians();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addCurrentLocationMarker() {
    _markers.add(
      Marker(
        point: _currentLocation,
        width: 80.0,
        height: 80.0,
        child:Icon(
          Icons.location_pin,
          color: Colors.blue,
          size: 40,
        ),
      ),
    );
  }

  void _loadNearbyVeterinarians() {
    List<LatLng> vetLocations = [
      LatLng(_currentLocation.latitude + 0.01, _currentLocation.longitude + 0.01),
      LatLng(_currentLocation.latitude - 0.01, _currentLocation.longitude - 0.01),
      LatLng(_currentLocation.latitude + 0.02, _currentLocation.longitude + 0.02),
    ];

    setState(() {
      for (var location in vetLocations) {
        _markers.add(
          Marker(
            point: location,
            width: 80.0,
            height: 80.0,
            child: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 40,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veterinarians Nearby'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.black,))
          : FlutterMap(
              options: MapOptions(
                initialCenter: _currentLocation,
                minZoom: 500.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: _markers),
              ],
            ),
    );
  }
}
