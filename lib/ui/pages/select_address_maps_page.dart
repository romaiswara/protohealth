part of 'pages.dart';

class SelectAddressMapsPage extends StatefulWidget {
  @override
  _SelectAddressMapsPageState createState() => _SelectAddressMapsPageState();
}

class _SelectAddressMapsPageState extends State<SelectAddressMapsPage> {
  final double _defaultZoom = 14.4746;
  final Set<Marker> _markers = {};
  GoogleMapController _mapController;
  int _posColorMarker = -1;
  LatLng _latLng;

  Future<void> _changeLocation(LatLng newLocation) async {
    return _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: newLocation,
          zoom: _defaultZoom,
        ),
      ),
    );
  }

  void _newMarker(LatLng point) async {
    setState(() {
      _latLng = point;
      _posColorMarker++;
      if (_posColorMarker > 2) {
        _posColorMarker = 0;
      }
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    _newMarker(
      (App.main.user != null && App.main.user.addressLatitude != null)
          ? LatLng(
              App.main.user.addressLatitude, App.main.user.addressLongitude)
          : LatLng(
              App.main.lastLocation.latitude,
              App.main.lastLocation.longitude,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConnectionCubit>(
        create: (_) => ConnectionCubit(),
        child: BlocListener<ConnectionCubit, ConnectionInternetState>(
          listener: (context, state) {
            if (state is NoConnectionState) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NoInternetPage()),
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                AppLocalizations.of(context)
                    .translate('account_set_home_location'),
                style: GoogleFonts.montserratAlternates(
                    color: SharedColor.COLOR_BLACK_400,
                    fontSize: ConstantFontSize.FONT_SIZE_16_0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.45),
                textAlign: TextAlign.right,
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () async {
                    _changeLocation(
                      LatLng(
                        App.main.lastLocation.latitude,
                        App.main.lastLocation.longitude,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Icon(Icons.my_location),
                  ),
                )
              ],
            ),
            body: Stack(
              children: <Widget>[
                GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: (App.main.user != null &&
                            App.main.user.addressLatitude != null)
                        ? LatLng(App.main.user.addressLatitude,
                            App.main.user.addressLongitude)
                        : LatLng(
                            App.main.lastLocation.latitude,
                            App.main.lastLocation.longitude,
                          ),
                    zoom: _defaultZoom,
                  ),
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  zoomControlsEnabled: false,
                  markers: _markers,
                  onTap: (latLng) {
                    if (_markers.length > 0) _markers.clear();
                    _newMarker(latLng);
                  },
                ),
                Positioned(
                  bottom: ConstantSpace.SPACE_2,
                  left: ConstantSpace.SPACE_2,
                  right: ConstantSpace.SPACE_2,
                  child: ButtonTheme(
                    height: ConstantSpace.SPACE_6,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ConstantSpace.SPACE_3),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: ConstantSpace.SPACE_2,
                      vertical: ConstantSpace.SPACE_1_5,
                    ),
                    buttonColor: SharedColor.COLOR_YELLOW_500,
                    child: RaisedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)
                                .translate('account_set_location'),
                            style: GoogleFonts.montserratAlternates(
                                letterSpacing: 0.8,
                                fontSize: ConstantFontSize.FONT_SIZE_14_0,
                                fontWeight: FontWeight.w500,
                                color: SharedColor.COLOR_PRIMARY),
                          ),
                          SizedBox(width: ConstantSpace.SPACE_1),
                          Icon(
                            Icons.home,
                            color: SharedColor.COLOR_PRIMARY,
                          ),
                        ],
                      ),
                      elevation: 0,
                      onPressed: () => Navigator.pop(context, _latLng),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
