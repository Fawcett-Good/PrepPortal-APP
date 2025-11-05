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
    for (int i = 0; i < 1000; i++) i.toString(),
  };

  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredRooms = [];

  // update when search
  void _onSearchChanged(String query) {
    const int NUM_SHOWN=4;//the amount shown on the searching bar
    setState(() {
      _filteredRooms = _rooms
        //.where((room) => room.toLowerCase().contains(query.toLowerCase())) //if want to support
        .toList();

      int roomNumberCompare(String a,String b){
        bool aFit=a.startsWith(query);
        bool bFit=b.startsWith(query);
        if (aFit && !bFit) return -1;
        if (!aFit && bFit) return 1;

        return a.compareTo(b);
      }
      final int listLength=_filteredRooms.length;
      List<String> searchResultList=[];
      for(int i=0;i<NUM_SHOWN&&i<listLength;i++){
        String min=_filteredRooms[i];
        int minIndex=i;
        for(int j=i;j<listLength;j++){
          if(roomNumberCompare(min,_filteredRooms[j])>0){
            min=_filteredRooms[j];
            minIndex=j;
          }
        }
        _filteredRooms[minIndex]=_filteredRooms[i];
        _filteredRooms[i]=min;
        searchResultList.add(min);
      }
      for (int i = 0; i < searchResultList.length; i++) {
        searchResultList[i] = "Room ${searchResultList[i]}";
      }
      _filteredRooms=searchResultList;
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
