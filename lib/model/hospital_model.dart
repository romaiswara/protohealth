part of 'model.dart';

@immutable
class HospitalModel extends Equatable {
  final int id;
  final String province;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String contact;
  final List<String> testFacility;

  HospitalModel(this.id, this.province, this.name, this.address, this.contact,
      this.latitude, this.longitude, this.testFacility);

  factory HospitalModel.fromSnapshot(DocumentSnapshot snapshot) {
    return HospitalModel(
      snapshot.data['id'],
      snapshot.data['province'],
      snapshot.data['name'],
      snapshot.data['address'],
      snapshot.data['contact'],
      snapshot.data['latitude'],
      snapshot.data['longitude'],
      (snapshot.data['test_facility'] as List)
          .map((facility) => facility.toString())
          .toList(),
    );
  }

  @override
  List<Object> get props => [
        id,
        province,
        name,
        address,
        latitude,
        longitude,
        contact,
        testFacility,
      ];
}
