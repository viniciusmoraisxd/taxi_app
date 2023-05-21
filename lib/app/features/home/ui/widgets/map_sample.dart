import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/app/features/home/data/usecases/remote_get_directions_usecase.dart';
import 'package:taxi_app/app/features/home/domain/entities/entities.dart';

import '../../../../core/core.dart';
import '../../../../shared/shared.dart';
import '../../domain/usecases/usecases.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController _controller;
  Marker? _origin;
  Marker? _destination;
  DirectionsEntity? _info;

  final GetDirectionUsecase getDirectionUsecase =
      RemoteGetDirectionUsecase(httpClient: GetIt.I.get<HttpClient>());

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(-18.848090, -41.934690),
    zoom: 14.5,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(-18.848090, -41.934690),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardBackgroundColor,
        actions: [
          if (_origin != null)
            TextButton(
                onPressed: () {
                  _controller.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: _origin!.position, zoom: 14.5, tilt: 50)));
                },
                child: const Text("ORIG")),
          if (_destination != null)
            TextButton(
                onPressed: () {
                  _controller.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: _destination!.position,
                          zoom: 14.5,
                          tilt: 50)));
                },
                child: const Text("DEST"))
        ],
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => _controller.animateCamera(
              // _info != null
              // ? CameraUpdate.newLatLngBounds(LatLngBounds(southwest: _info!.bounds.southwest, northeast: northeast) , 100):
              CameraUpdate.newCameraPosition(_initialCameraPosition))),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            markers: {
              if (_origin != null) _origin!,
              if (_destination != null) _destination!,
            },
            onLongPress: _addMarker,
            // mapType: MapType.normal,
            polylines: {
              if (_info != null)
                Polyline(
                    polylineId: const PolylineId("overview_polyline"),
                    color: Colors.red,
                    width: 5,
                    points: _info!.polylinePoints
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList())
            },
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          ),
          if (_info != null)
            Positioned(
              top: 40,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6),
                    ]),
                child: Text(
                  "${_info?.totalDistance}, ${_info?.totalDuration}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            )
        ],
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      //Origin is not set or Origin/Destination are both set

      setState(() {
        _origin = Marker(
            markerId: const MarkerId("origin"),
            infoWindow: const InfoWindow(title: "Origin"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
            position: pos);
        _destination = null;
        _info = null;
      });
    } else {
      // Origin is already set, set destination
      setState(() {
        _destination = Marker(
            markerId: const MarkerId("destination"),
            infoWindow: const InfoWindow(title: "Destination"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
            position: pos);
      });

      final directions = await getDirectionUsecase(
          origin: _origin!.position, destination: _destination!.position);

      setState(() {
        _info = directions;
      });
    }
  }
  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
