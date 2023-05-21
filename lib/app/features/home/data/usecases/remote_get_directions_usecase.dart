import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/app/core/http/data/data.dart';
import 'package:taxi_app/app/features/home/domain/entities/entities.dart';

import '../../domain/usecases/usecases.dart';
import '../models/models.dart';

class RemoteGetDirectionUsecase implements GetDirectionUsecase {
  final HttpClient httpClient;

  RemoteGetDirectionUsecase({required this.httpClient});
  @override
  Future<DirectionsEntity> call(
      {required LatLng origin, required LatLng destination}) async {
    try {
      final response = await httpClient
          .request(path: "directions/json?", method: HttpMethods.get, body: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': FlutterConfig.get('ANDROID_MAPS_API_KEY')
      });

      return DirectionsModel.fromMap(response).toEntity();
    } catch (e) {
      throw Exception();
    }
  }
}
