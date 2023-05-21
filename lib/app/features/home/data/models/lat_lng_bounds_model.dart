import 'package:taxi_app/app/features/home/data/models/models.dart';

import '../../domain/entities/entities.dart';

class LatLngBoundsModel extends LatLngBoundsEntity {
  LatLngBoundsModel({required super.northeast, required super.southwest});

  factory LatLngBoundsModel.fromMap(Map<String, dynamic> map) =>
      LatLngBoundsModel(
          northeast: LatLngModel.fromMap(map['northeast']).toEntity(),
          southwest: LatLngModel.fromMap(map['southwest']).toEntity());

  LatLngBoundsEntity toEntity() =>
      LatLngBoundsEntity(northeast: northeast, southwest: southwest);
}
