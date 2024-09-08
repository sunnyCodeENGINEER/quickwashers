import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class UserLocationScreen extends StatefulWidget {
  const UserLocationScreen({super.key});

  @override
  State<UserLocationScreen> createState() => _UserLocationScreenState();
}

class _UserLocationScreenState extends State<UserLocationScreen> {
  LatLng _currentPosition = const LatLng(0.0, 0.0);
  String address = 'Your Address';
  String place = 'Home';
  final MapController _mapController = MapController();
  bool _isMapReady = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  // Get user's current location and update the map and marker when it's ready
  Future<void> _getUserLocation() async {
    await Permission.locationWhenInUse.request();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      if (_isMapReady) {
        _mapController.move(_currentPosition, 17.0);
      }
      _searchAddress(_currentPosition).toString();
      debugPrint(address);
    });
  }

  Future<void> _searchAddress(LatLng position) async {
    // String? address;
    try {
      // Get placemarks from coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      // Check if any placemarks were found
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        setState(() {
          address =
              '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
        });
      }
    } catch (e) {
      debugPrint("Error occurred while fetching address: $e");
    }
    // return address;
  }

  // Search for a location by name or address and move the map to that location
  Future<void> _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);

      if (locations.isNotEmpty) {
        final Location location = locations.first;
        LatLng newPosition = LatLng(location.latitude, location.longitude);

        setState(() {
          _currentPosition = newPosition;
          _mapController.move(_currentPosition, 17.0);
          _searchAddress(_currentPosition);
        });
      }
    } catch (e) {
      debugPrint("Location not found: $e");
      // You can show a dialog or snack bar to notify the user that the search failed
    }
  }

  Future<List<Location>?> _searchLocations(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);

      return locations;
    } catch (e) {
      debugPrint("Location not found: $e");
      // You can show a dialog or snack bar to notify the user that the search failed
      return null;
    }
  }

  void _setLocation() {
    // Logic to set location goes here
  }

  void _saveLocation() {
    // Logic to save location goes here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left)),
        title: const Text('Set delivery location'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Search Field for location search
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIconColor: Colors.grey,
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: IconButton(
                      onPressed: () {
                        _searchLocation(searchController.text);
                      },
                      icon: Image.asset(
                        'assets/images/search.png',
                        width: 30,
                      ),
                    ),
                    hintText: 'Search location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 176, 176, 176),
                        width: 2.0,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    // implement searching as typing
                  },
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _searchLocation(value); // Search for the location
                    }
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  clipBehavior: Clip.hardEdge,
                  height: 600,
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      onMapReady: () {
                        setState(() {
                          _isMapReady = true;
                          if (_currentPosition != const LatLng(0.0, 0.0)) {
                            _mapController.move(_currentPosition, 17.0);
                            _searchAddress(_currentPosition);
                          }
                        });
                      },
                      initialCenter: LatLng(_currentPosition.latitude,
                          _currentPosition.longitude),
                      initialZoom: 15,
                      onTap: (tapPosition, point) {
                        setState(() {
                          _currentPosition = point;
                        });
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                        maxNativeZoom: 19,
                      ),
                      RichAttributionWidget(
                        attributions: [
                          TextSourceAttribution('OpenStreetMap contributors',
                              onTap: () {}),
                        ],
                      ),
                      // Adding the MarkerLayer for pins (marker)
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: _currentPosition,
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  color: Colors.blue,
                                  size: 40,
                                ),
                                SizedBox(
                                  height: 1,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(address),
                      const Text('FLAT NUM. LANDMARK, APARTMENT, ETC.'),
                      const TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                      const Divider(),
                      const Text('SAVE ADDRESS AS'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LocationButton(
                            label: 'Home',
                            icon: 'assets/images/House.png',
                            place: place,
                            onSelect: (newPlace) {
                              setState(() {
                                place = newPlace;
                              });
                            },
                          ),
                          LocationButton(
                            label: 'Office',
                            icon: 'assets/images/Office.png',
                            place: place,
                            onSelect: (newPlace) {
                              setState(() {
                                place = newPlace;
                              });
                            },
                          ),
                          LocationButton(
                            label: 'Other',
                            icon: 'assets/images/Location pin.png',
                            place: place,
                            onSelect: (newPlace) {
                              setState(() {
                                place = newPlace;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Continue'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LocationButton extends StatelessWidget {
  final String label;
  final String icon;
  final String place;
  final Function(String) onSelect;

  const LocationButton({
    super.key,
    required this.label,
    required this.icon,
    required this.place,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onSelect(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: place == label ? Colors.blue : Colors.grey,
        foregroundColor: Colors.white,
      ),
      child: Row(
        children: [Image.asset(icon), Text(label)],
      ),
    );
  }
}
