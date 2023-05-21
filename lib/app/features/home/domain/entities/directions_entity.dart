import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'entities.dart';

class DirectionsEntity {
  final LatLngBoundsEntity bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  DirectionsEntity(
      {required this.bounds,
      required this.polylinePoints,
      required this.totalDistance,
      required this.totalDuration});
}

