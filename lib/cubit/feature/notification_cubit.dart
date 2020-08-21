part of '../cubit.dart';

////////////////////////////////////////////////
//// STATE AREA ////////////////////////////////
////////////////////////////////////////////////
abstract class NotificationState extends Equatable {}

class NotificationInitialState extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationLoadingState extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationSendState extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationFailureState extends NotificationState {
  final String errorMessage;

  NotificationFailureState({
    this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

////////////////////////////////////////////////
//// CUBIT AREA ////////////////////////////////
////////////////////////////////////////////////
class NotificationCubit extends Cubit<NotificationState> {
  final Logger logger = Logger('Notification Cubit');

  NotificationCubit() : super(NotificationInitialState());

  void sendNotification({
    User user,
    String body,
    String status,
  }) async {
    logger.fine('sendNotification');
    emit(NotificationLoadingState());
    try {
      FormData formData = FormData.fromMap({
        "notification": {
          "title": "Reminder",
          "body": "Abaikan!",
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        },
        "data": {
          "id": "121212",
          "user_id": "121daajsa",
          "status": "1",
          "time": "now"
        },
        "to": App.main.firebaseToken,
      });

      Response response = await Dio().post(
        ConstantString.URL_FCM,
        data: formData,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': ConstantString.KEY_FCM,
        }),
      );
      logger.fine('Response data: ${response.data}');
      emit(NotificationSendState());
    } catch (e) {
      logger.fine('Response error: ${e.toString()}');
      emit(NotificationFailureState(errorMessage: e.toString()));
    }
  }

  void sendNotificationWithHttp({
    User user,
    String body,
    String status,
  }) async {
    logger.fine('sendNotification');
    emit(NotificationLoadingState());
    try {
      var response = await http.post(
        ConstantString.URL_FCM,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': ConstantString.KEY_FCM,
        },
        body: jsonEncode(<String, dynamic>{
          "notification": {
            "title": "Reminder",
            "body": body,
            "click_action": "FLUTTER_NOTIFICATION_CLICK"
          },
          "data": {
            "user_id": user.id,
            "status": status,
          },
          "to": App.main.firebaseToken,
        }),
      );
      logger.fine('Response data: ${response.body}');
      emit(NotificationSendState());
    } catch (e) {
      logger.fine('Response error: ${e.toString()}');
      emit(NotificationFailureState(errorMessage: e.toString()));
    }
  }
}
