import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// MapScreen widget
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  // our school's location
  final LatLng _fairmontLocation = const LatLng(33.8441288298607, -117.96026306038686);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // maps
        GoogleMap(
          onMapCreated: (controller) => mapController = controller,
          initialCameraPosition: CameraPosition(
            target: _fairmontLocation,
            zoom: 18.0,
          ),
          markers: {
            Marker(
              markerId: const MarkerId("fairmont"),
              position: _fairmontLocation,
              infoWindow: const InfoWindow(title: "Fairmont Preparatory Academy"),
            ),
          },
        ),
        // search box
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search for a room number...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
