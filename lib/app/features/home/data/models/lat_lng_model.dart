import '../../domain/entities/entities.dart';

class LatLngModel extends LatLngEntity {
  LatLngModel({required super.latitude, required super.longitude});

  factory LatLngModel.fromMap(Map<String, dynamic> map) =>
      LatLngModel(latitude: map['lat'], longitude: map['lng']);
      
  LatLngEntity toEntity() =>
      LatLngEntity(latitude: latitude, longitude: longitude);
}
