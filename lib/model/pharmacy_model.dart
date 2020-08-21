part of 'model.dart';

@immutable
class PharmacyModel extends Equatable {
  final int id;
  final String name;
  final String city;
  final double latitude;
  final double longitude;
  final double distance;
  final String contact;

  PharmacyModel({
    this.id,
    this.name,
    this.city,
    this.latitude,
    this.longitude,
    this.distance,
    this.contact,
  });

  @override
  List<Object> get props => [
        id,
        name,
        city,
        latitude,
        longitude,
        distance,
        contact,
      ];
}

List<PharmacyModel> listPharmacy({
  double lat,
  double lng,
  String city,
}) {
  return List.generate(40, (index) {
    return PharmacyModel(
      id: (index + 1),
      name: 'Apotek ${index + 1}',
      contact: '0812345678${index + 1}',
      latitude: lat + ((index + 1) * 0.002),
      longitude: lng,
      city: city,
      distance: (index + 1).toDouble() + 0.38,
    );
  });
}
