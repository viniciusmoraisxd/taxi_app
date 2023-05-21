import 'entities.dart';

class LatLngBoundsEntity {
  final LatLngEntity southwest;
  final LatLngEntity northeast;

  LatLngBoundsEntity({required this.southwest, required this.northeast});
}
