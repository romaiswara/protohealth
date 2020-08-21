part of '../cubit.dart';

////////////////////////////////////////////////
//// STATE AREA ////////////////////////////////
////////////////////////////////////////////////
class GoogleMapState extends Equatable {
  final Set<Marker> markers;

  GoogleMapState({
    Set<Marker> markers,
  }) : markers = markers ?? Set<Marker>();

  @override
  List<Object> get props => [];
}

////////////////////////////////////////////////
//// CUBIT AREA ////////////////////////////////
////////////////////////////////////////////////

class GoogleMapCubit extends Cubit<GoogleMapState> {
  GoogleMapController controller;

  GoogleMapCubit() : super(GoogleMapState());

  void setMarkers(Set<Marker> markers) {
    emit(GoogleMapState(markers: markers));
  }

  Future<void> changeLocation(LatLng newLocation) async {
    return controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: newLocation,
          zoom: 14,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
