part of 'service.dart';

class HistoryService {
  static CollectionReference _historyCollection =
      Firestore.instance.collection('history');

  static Future<void> addHistory(String userId, String status) async {
    _historyCollection.document().setData({
      'user_id': userId,
      'status': status,
      'time': DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now()),
      'time_millis': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Stream<List<HistoryModel>> getHistoryStream(String userId) {
    return _historyCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .where((doc) => doc.data['user_id'] == userId)
          .map((element) => HistoryModel.fromSnapshot(element))
          .toList();
    });
  }

  static Future<List<HistoryModel>> getHistory(String userId) async {
    QuerySnapshot snapshot = await _historyCollection
        .orderBy('time_millis', descending: true)
        .getDocuments();
    return snapshot.documents
        .where((doc) => doc.data['user_id'] == userId)
        .map((e) => HistoryModel.fromSnapshot(e))
        .toList();
  }
}
