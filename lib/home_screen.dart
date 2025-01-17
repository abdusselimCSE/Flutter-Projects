import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map Screen"),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: const CameraPosition(
          zoom: 16,
          target: LatLng(
            24.92779426734168,
            91.97159409349332,
          ),
        ),
        onTap: (LatLng? latLng) {
          print(latLng);
        },
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
        trafficEnabled: true,
        markers: <Marker>{
          Marker(
            markerId: const MarkerId('initial-position'),
            position: const LatLng(
              24.92779426734168,
              91.97159409349332,
            ),
            infoWindow: InfoWindow(
              title: "Metro",
              onTap: () {
                print('On tapped Home');
              },
            ),
          ),
          Marker(
            markerId: const MarkerId('home'),
            position: const LatLng(
              24.92981160923326,
              91.97061158716679,
            ),
            infoWindow: InfoWindow(
              title: "Home",
              onTap: () {
                print('On tapped Home');
              },
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            draggable: true,
            onDragStart: (LatLng onStartLatLng) {
              print("On start drag $onStartLatLng");
            },
            onDragEnd: (LatLng onEndLatLng) {
              print("On end drag $onEndLatLng");
            },
          ),
        },
        circles: <Circle>{
          Circle(
              circleId: const CircleId('initial-circle'),
              fillColor: Colors.red.withOpacity(0.3),
              center: const LatLng(
                24.92779426734168,
                91.97159409349332,
              ),
              radius: 300,
              strokeColor: Colors.blue,
              strokeWidth: 1,
              visible: true,
              onTap: () {
                print("Enter into dengue zone");
              }),
        },
        polylines: <Polyline>{
          const Polyline(
            polylineId: PolylineId('random'),
            color: Colors.amber,
            width: 4,
            jointType: JointType.round,
            points: <LatLng>[
              LatLng(24.924512135398892, 91.96788176894188),
              LatLng(24.923331504434792, 91.96875415742397),
              LatLng(24.92383106200149, 91.97165094316006),
              LatLng(24.924485987114686, 91.97328172624111),
            ],
          ),
        },
        polygons: <Polygon>{
          Polygon(
            polygonId: const PolygonId('poly-id'),
            fillColor: Colors.pink.withOpacity(0.4),
            strokeColor: Colors.black,
            strokeWidth: 2,
            points: <LatLng>[
              const LatLng(24.922799715123652, 91.97312448173761),
              const LatLng(24.923188903638163, 91.97240196168423),
              const LatLng(24.923590861111286, 91.97318885475397),
              const LatLng(24.922734647548996, 91.97375379502772)
            ],
          ),
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 16,
                target: LatLng(
                  24.92779426734168,
                  91.97159409349332,
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.location_history),
      ),
    );
  }
}
