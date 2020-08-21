part of 'service.dart';

class HospitalService {
  static CollectionReference _hospitalCollection =
      Firestore.instance.collection('hospitals');

  static Future<void> saveHospital({HospitalModel hospitalModel}) async {
    await _hospitalCollection.document(hospitalModel.id.toString()).setData({
      'id': hospitalModel.id,
      'province': hospitalModel.province,
      'name': hospitalModel.name,
      'address': hospitalModel.address,
      'latitude': hospitalModel.latitude,
      'longitude': hospitalModel.longitude,
      'contact': hospitalModel.contact,
      'test_facility': hospitalModel.testFacility,
    });
  }

  static Stream<List<HospitalModel>> getHospitalStream() {
    return _hospitalCollection.orderBy('id').snapshots().map((snapshot) {
      return snapshot.documents
          .map((hospital) => HospitalModel.fromSnapshot(hospital))
          .toList();
    });
  }

  static Future<List<HospitalModel>> getHospital() async {
    QuerySnapshot snapshot = await _hospitalCollection.orderBy('id').getDocuments();
    return snapshot.documents
        .map((e) => HospitalModel.fromSnapshot(e))
        .toList();
  }
}
