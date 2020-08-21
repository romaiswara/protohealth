part of 'model.dart';

class HistoryModel extends Equatable {
  final String userId;
  final String status;
  final String time;

  HistoryModel({
    this.userId,
    this.status,
    this.time,
  });

  factory HistoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    return HistoryModel(
      userId: snapshot.data['user_id'],
      status: snapshot.data['status'],
      time: snapshot.data['time'],
    );
  }

  @override
  List<Object> get props => [userId, status, time];
}
