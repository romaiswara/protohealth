part of '../cubit.dart';

////////////////////////////////////////////////
//// STATE AREA ////////////////////////////////
////////////////////////////////////////////////
abstract class HistoryState extends Equatable {}

class HistoryInitialState extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoadingState extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoadedState extends HistoryState {
  final List<HistoryModel> histories;

  HistoryLoadedState({
    this.histories,
  });

  @override
  List<Object> get props => [histories];
}

class HistoryFailureState extends HistoryState {
  final String errorMessage;

  HistoryFailureState({
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
class HistoryCubit extends Cubit<HistoryState> {
  final Logger logger = Logger('History Cubit');
  StreamSubscription _historySubscription;

  HistoryCubit() : super(HistoryInitialState());

  void addHistory({String userId, String status}) async {
    logger.fine('add history userId: $userId, status: $status');
    try {
      await HistoryService.addHistory(userId, status);
      logger.fine('Success add history $userId');
      getHistoryCubit(userId);
    } catch (e) {
      logger.fine('Failed add history ${e.toString()}');
    }
  }

  void getHistoryCubit(String userId) async {
    logger.fine('Success get history by ${userId}');
    try {
      List<HistoryModel> histories = await HistoryService.getHistory(userId);
      logger.fine('Success get histories ${histories.length}');
      emit(HistoryLoadedState(histories: histories));
    } catch (e) {
      logger.fine('Failed get histories ${e.toString()}');
      emit(HistoryFailureState(errorMessage: e));
    }
  }

  void getHistoryStreamCubit(String userId) {
    logger.fine('Success get history stream by ${userId}');
    _historySubscription =
        HistoryService.getHistoryStream(userId).listen((histories) {
      logger.fine('Success get histories ${histories.length}');
      emit(HistoryLoadedState(histories: histories));
    }, onError: (e) {
      logger.fine('Failed get histories ${e.toString()}');
      emit(HistoryFailureState(errorMessage: e));
    });
  }

  void cancelHistory() {
    if (_historySubscription != null) _historySubscription.cancel();
  }

  @override
  Future<void> close() async {
    await _historySubscription?.cancel();
    return super.close();
  }
}
