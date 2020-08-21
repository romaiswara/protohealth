part of 'model.dart';

class NotificationModel extends Equatable {
  final String id;
  final String userId;
  final String status;
  final String time;

  NotificationModel({
    this.id,
    this.userId,
    this.status,
    this.time,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: (json['data'])['id'],
      userId: (json['data'])['user_id'],
      status: (json['data'])['status'],
      time: (json['data'])['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status,
      'time': time,
    };
  }

  @override
  List<Object> get props => [
        id,
        userId,
        status,
        time,
      ];

  @override
  String toString() {
    return 'NotificationModel{id: $id, userId: $userId, status: $status, time: $time}';
  }
}
