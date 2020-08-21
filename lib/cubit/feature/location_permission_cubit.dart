part of '../cubit.dart';

////////////////////////////////////////////////
//// STATE AREA ////////////////////////////////
////////////////////////////////////////////////
abstract class LocationPermissionState extends Equatable {
  @override
  List<Object> get props => [];
}

class LocationPermissionInitState extends LocationPermissionState {}

class LocationPermissionLoadingState extends LocationPermissionState {}

class LocationPermissionSucceededState extends LocationPermissionState {}

class LocationPermissionFailureState extends LocationPermissionState {
  final int code;
  final String message;

  LocationPermissionFailureState({
    this.code,
    this.message,
  });
}

////////////////////////////////////////////////
//// CUBIT AREA ////////////////////////////////
////////////////////////////////////////////////
class LocationPermissionCubit extends Cubit<LocationPermissionState> {
  LocationPermissionCubit() : super(LocationPermissionInitState());

  void checkLocationPermission() async {
    emit(LocationPermissionLoadingState());
    Location location = Location();

    // check location permission
    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied ||
        _permissionGranted == PermissionStatus.deniedForever) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted == PermissionStatus.denied ||
          _permissionGranted == PermissionStatus.deniedForever) {
        // throw to error
        emit(LocationPermissionFailureState(
          code: 100,
          message: 'Location Permission Denied',
        ));
      }
    }

    // check service location
    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        // throw to error
        emit(LocationPermissionFailureState(
          code: 100,
          message: 'Location Permission Denied',
        ));
      }
    } else {
      emit(LocationPermissionSucceededState());
    }
  }
}
