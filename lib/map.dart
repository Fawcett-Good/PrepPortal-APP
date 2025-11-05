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

  // rooms list
  final Set<String> _rooms = {
    "1","2","11","12","21","22"
  };

  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredRooms = [];

  // update when search
  void _onSearchChanged(String query) {
    setState(() {
      _filteredRooms = _rooms
          .where((room) => room.toLowerCase().contains(query.toLowerCase()))
          .toList();
      var roomNumberCompare=(String a,String b){
        bool aFit=a.substring(0,query.length)==query;
        bool bFit=b.substring(0,query.length)==query;
        if (aFit && !bFit) return -1;
        if (!aFit && bFit) return 1;

        return a.compareTo(b);
      };
      for (int i = 0; i < _filteredRooms.length; i++) {
        _filteredRooms[i] = "Room ${_filteredRooms[i]}";
      }

    });
  }

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
            child: Column(
              children: [
                Container(
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
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged, //update when search
                    decoration: const InputDecoration(
                      hintText: 'Search for a room number...',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),

                //
                if (_filteredRooms.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .05),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filteredRooms.length,
                      itemBuilder: (context, index) {
                        final room = _filteredRooms[index];
                        return ListTile(
                          title: Text(room),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
