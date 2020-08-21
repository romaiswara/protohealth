part of '../cubit.dart';

/// STATE
abstract class ConnectionInternetState extends Equatable {
  const ConnectionInternetState();

  @override
  List<Object> get props => [];
}

class ConnectionInitState extends ConnectionInternetState {}

class AvailableConnectionState extends ConnectionInternetState {}

class NoConnectionState extends ConnectionInternetState {}

/// CUBIT
class ConnectionCubit extends Cubit<ConnectionInternetState> {
  StreamSubscription _connectionStream;

  ConnectionCubit() : super(ConnectionInitState()) {
    _connectionStream = Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        emit(AvailableConnectionState());
      } else {
        emit(NoConnectionState());
      }
    });
  }

  @override
  Future<void> close() {
    _connectionStream.cancel();
    return super.close();
  }
}
