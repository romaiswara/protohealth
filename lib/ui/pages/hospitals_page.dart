part of 'pages.dart';

class HospitalsPage extends StatefulWidget {
  const HospitalsPage({Key key}) : super(key: key);

  @override
  _HospitalsPageState createState() => _HospitalsPageState();
}

class _HospitalsPageState extends State<HospitalsPage>
    with TickerProviderStateMixin {
  final Logger logger = Logger('Hospital Page');
  final GoogleMapCubit _mapCubit = GoogleMapCubit();
  final HospitalCubit _hospitalCubit = HospitalCubit();
  @override
  void initState() {
    super.initState();
    _hospitalCubit.getHospital();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// HANDLE GOOGLE MAPS
        BlocProvider<GoogleMapCubit>(
          create: (_) => _mapCubit,
        ),

        /// FOR HOSPITAL
        BlocProvider<HospitalCubit>(
          create: (_) => _hospitalCubit,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<GoogleMapCubit, GoogleMapState>(
            listener: (context, state) {
              logger.fine('Google Map State ${state.toString()}');
            },
          ),
          BlocListener<HospitalCubit, HospitalState>(
            listener: (context, state) {
              logger.fine('Hospital State ${state.toString()}');
              if (state is HospitalLoadedState) {
                context.bloc<GoogleMapCubit>().setMarkers(
                      state.list.map<Marker>((hospital) {
                        return Marker(
                            markerId: MarkerId(hospital.id.toString()),
                            icon: BitmapDescriptor.defaultMarker,
                            position: LatLng(
                              hospital.latitude,
                              hospital.longitude,
                            ),
                            onTap: () {
                              CommonsWidget().showModalSheet(
                                context: context,
                                body: _containerOnModalBottomSheet(
                                    context, hospital, false),
                              );
                            });
                      }).toSet(),
                    );
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              AppLocalizations.of(context).translate('hospital_location'),
              style: GoogleFonts.montserratAlternates(
                  color: SharedColor.COLOR_BLACK_400,
                  fontSize: ConstantFontSize.FONT_SIZE_16_0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.45),
              textAlign: TextAlign.right,
            ),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Container(
                    alignment: Alignment.center,
                    child: BlocBuilder<GoogleMapCubit, GoogleMapState>(
                      builder: (context, state) {
                        return GoogleMap(
                          myLocationEnabled: true,
                          compassEnabled: false,
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: App.main.lastLocation,
                            zoom: 14,
                          ),
                          markers: state.markers,
                          onMapCreated: (GoogleMapController controller) {
                            context.bloc<GoogleMapCubit>().controller =
                                controller;
                          },
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: BlocBuilder<HospitalCubit, HospitalState>(
                    builder: (context, state) {
                      if (state is HospitalLoadingState) {
                        return Center(
                          child: LoaderListNearbyHopitals(),
                        );
                      }
                      if (state is HospitalLoadedState) {
                        return ListNearbyHospitals(
                          list: state.list,
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _containerOnModalBottomSheet(
      BuildContext context, HospitalModel hospitalModel, bool isLocInfo) {
    return Container(
      padding: EdgeInsets.only(
        left: ConstantSpace.SPACE_4,
        right: ConstantSpace.SPACE_4,
        bottom: ConstantSpace.SPACE_3_5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              '${hospitalModel.name}',
              style: GoogleFonts.montserratAlternates(
                  color: SharedColor.COLOR_BLACK_400,
                  fontSize: ConstantFontSize.FONT_SIZE_14_0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5),
            ),
          ),
          SizedBox(height: ConstantSpace.SPACE_4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 110,
                width: 120,
                child: CustomImageNetwork(
                  borderRadiusVal: ConstantSpace.SPACE_1_5,
                  imageUrl:
                      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
                ),
              ),
              SizedBox(width: ConstantSpace.SPACE_2),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: ConstantSpace.SPACE_0_5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${hospitalModel.address}',
                        style: GoogleFonts.montserratAlternates(
                            color: SharedColor.COLOR_BLACK_300,
                            fontSize: ConstantFontSize.FONT_SIZE_12_0,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: ConstantSpace.SPACE_1),
                      Text(
                        '${hospitalModel.province}',
                        style: GoogleFonts.montserratAlternates(
                            color: SharedColor.COLOR_BLACK_400,
                            fontSize: ConstantFontSize.FONT_SIZE_12_0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5),
                      ),
                      SizedBox(height: ConstantSpace.SPACE_1),
                      Text(
                        '${hospitalModel.contact}',
                        style: GoogleFonts.montserratAlternates(
                            color: SharedColor.COLOR_BLACK_400,
                            fontSize: ConstantFontSize.FONT_SIZE_13_0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ConstantSpace.SPACE_3),
          Text(
            AppLocalizations.of(context).translate('hospital_covid_available'),
            style: GoogleFonts.montserratAlternates(
                color: SharedColor.COLOR_BLACK_400,
                fontSize: ConstantFontSize.FONT_SIZE_13_0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5),
          ),
          SizedBox(height: ConstantSpace.SPACE_1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                  flex: 1, child: Wrap(children: item(hospitalModel).toList())),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: ConstantSpace.SPACE_7_5,
                      height: ConstantSpace.SPACE_7_5,
                      child: FlatButton(
                        color: SharedColor.COLOR_GREEN_500,
                        shape: CircleBorder(),
                        onPressed: () {},
                        child: Icon(
                          Icons.location_on,
                          size: 30,
                          color: SharedColor.COLOR_BLACK_100,
                        ),
                      ),
                    ),
                    SizedBox(width: ConstantSpace.SPACE_1),
                    ButtonTheme(
                      minWidth: ConstantSpace.SPACE_7_5,
                      height: ConstantSpace.SPACE_7_5,
                      child: FlatButton(
                        color: SharedColor.COLOR_YELLOW_500,
                        shape: CircleBorder(),
                        onPressed: () {},
                        child: Icon(
                          Icons.call,
                          size: 30,
                          color: SharedColor.COLOR_BLACK_100,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Iterable<Widget> item(HospitalModel hospitalModel) sync* {
    for (var item in hospitalModel.testFacility) {
      yield Container(
        margin: EdgeInsets.only(right: ConstantSpace.SPACE_1),
        child: Chip(
          backgroundColor: SharedColor.COLOR_YELLOW_400,
          label: Text(
            item,
            style: GoogleFonts.montserratAlternates(
                color: SharedColor.COLOR_PRIMARY,
                fontSize: ConstantFontSize.FONT_SIZE_12_0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5),
          ),
        ),
      );
    }
  }
}
