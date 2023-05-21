import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/app/features/home/domain/entities/entities.dart';

abstract class GetDirectionUsecase {
  Future<DirectionsEntity> call({
    required LatLng  origin,
    required LatLng  destination
  });
}
