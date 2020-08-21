part of 'model.dart';

@immutable
class LocationTestCovidModel extends Equatable {
  final int id;
  final String name;
  final String city;
  final double latitude;
  final double longitude;
  final double distance;
  final String contact;
  final List<String> testFacility;

  LocationTestCovidModel({
    this.id,
    this.name,
    this.city,
    this.latitude,
    this.longitude,
    this.distance,
    this.contact,
    this.testFacility,
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
        testFacility,
      ];
}

List<LocationTestCovidModel> listLocationTestCovid({
  double lat,
  double lng,
  String city,
}) {
  return List.generate(10, (index) {
    return LocationTestCovidModel(
      id: (index + 1),
      name: 'Lokasi Test Covid ${(index + 1)}',
      city: city,
      contact: '0812345678${(index + 1)}',
      distance: index.toDouble() + 0.24,
      latitude: lat,
      longitude: lng + ((index + 1) * 0.005),
      testFacility: ((index + 1) % 2 == 1)
          ? ['Swab Test', 'Rapid Test', 'TCM']
          : ['Rapid Test'],
    );
  });
}
