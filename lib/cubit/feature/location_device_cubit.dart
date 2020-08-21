part of '../cubit.dart';

////////////////////////////////////////////////
//// STATE AREA ////////////////////////////////
////////////////////////////////////////////////
abstract class LocationDeviceState extends Equatable {
  @override
  List<Object> get props => [];
}

class LocationDeviceInitState extends LocationDeviceState {}

class LocationDeviceLoadingState extends LocationDeviceState {}

class LocationDeviceLoadedState extends LocationDeviceState {
  final double latitude;
  final double longitude;
  final String city;

  LocationDeviceLoadedState({
    this.latitude,
    this.longitude,
    this.city,
  });

  @override
  List<Object> get props => [latitude, longitude];
}

class LocationDeviceFailureState extends LocationDeviceState {
  final int code;
  final String message;

  LocationDeviceFailureState({
    this.code,
    this.message,
  });
}

////////////////////////////////////////////////
//// CUBIT AREA ////////////////////////////////
////////////////////////////////////////////////
class LocationDeviceCubit extends Cubit<LocationDeviceState> {
  LocationDeviceCubit() : super(LocationDeviceInitState());

  void getCurrentLocation() async {
    emit(LocationDeviceLoadingState());

    // initiate location library
    Location location = Location();

    // check location permission
    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied ||
        _permissionGranted == PermissionStatus.deniedForever) {
      // throw to error
      emit(LocationDeviceFailureState(
        code: 100,
        message: 'Location Permission Denied',
      ));
    }

    // check service location
    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      // throw to error
      emit(LocationDeviceFailureState(
        code: 100,
        message: 'Location Service Disabled',
      ));
    }

    LocationData data = await location.getLocation();

    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(data.latitude, data.longitude);

    emit(LocationDeviceLoadedState(
      latitude: data.latitude,
      longitude: data.longitude,
      city: placemark[0].subLocality +
          ", " +
          placemark[0].subAdministrativeArea +
          ", ",
    ));
  }

  void updateLocation(double latitude, double longitude) async {
    emit(LocationDeviceLoadingState());

    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(latitude, longitude);
    emit(
      LocationDeviceLoadedState(
        latitude: latitude,
        longitude: longitude,
        city: placemark[0].subLocality +
            ", " +
            placemark[0].subAdministrativeArea +
            ", ",
      ),
    );
  }

  void listenLocation() async {
    await Future.delayed(Duration(milliseconds: 500));
    bl.BackgroundLocation.startLocationService();
    bl.BackgroundLocation.getLocationUpdates((location) async {
      emit(LocationDeviceLoadingState());
//        checkDistanceLocation(context, location.latitude, location.longitude);
      String latitude = location.latitude.toString();
      String longitude = location.longitude.toString();
      String accuracy = location.accuracy.toString();
      String altitude = location.altitude.toString();
      String bearing = location.bearing.toString();
      String speed = location.speed.toString();
      String time =
          DateTime.fromMillisecondsSinceEpoch(location.time.toInt()).toString();

      print("""\n
      Latitude:  $latitude
      Longitude: $longitude
      Altitude: $altitude
      Accuracy: $accuracy
      Bearing:  $bearing
      Speed: $speed
      Time: $time
      """);
      var result = await (Connectivity().checkConnectivity());
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        try {
          List<Placemark> placemark = await Geolocator()
              .placemarkFromCoordinates(location.latitude, location.longitude);

          emit(LocationDeviceLoadedState(
              latitude: location.latitude,
              longitude: location.longitude,
              city: placemark[0].subLocality +
                  ", " +
                  placemark[0].subAdministrativeArea +
                  ", "));
        } catch (e) {}
      }
    });
  }

  @override
  Future<void> close() async {
    return super.close();
  }
}
