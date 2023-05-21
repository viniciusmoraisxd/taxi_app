import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:taxi_app/app/features/home/data/models/models.dart';
import 'package:taxi_app/app/features/home/domain/entities/entities.dart';

class DirectionsModel extends DirectionsEntity {
  DirectionsModel(
      {required super.bounds,
      required super.polylinePoints,
      required super.totalDistance,
      required super.totalDuration});

  factory DirectionsModel.fromMap(Map<String, dynamic> map) {
    if ((map['routes'] as List).isEmpty) throw Exception();

    final data = Map<String, dynamic>.from(map['routes'][0]);

    String distance = "";
    String duration = "";

    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }

    return DirectionsModel(
        bounds: LatLngBoundsModel.fromMap(data['bounds']),
        polylinePoints: PolylinePoints()
            .decodePolyline(data['overview_polyline']['points']),
        totalDistance: distance,
        totalDuration: duration);
  }

  DirectionsEntity toEntity() => DirectionsEntity(
      bounds: bounds,
      polylinePoints: polylinePoints,
      totalDistance: totalDistance,
      totalDuration: totalDuration);
}
