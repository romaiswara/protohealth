part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  final String id;

  ProfilePage({
    this.id,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Logger logger = Logger('Profile Page');
  final GoogleMapCubit _mapCubit = GoogleMapCubit();
  final UserCubit _userCubit = UserCubit();

  final Set<Marker> _markers = {};
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GoogleMapCubit>(
          create: (_) => _mapCubit,
        ),
        BlocProvider<UserCubit>(
          create: (_) => _userCubit..getUser(id: widget.id),
        ),
        /// FOR CONNECTION
        BlocProvider<ConnectionCubit>(
          create: (_) => ConnectionCubit(),
        ),
      ],
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
              'Profile',
              style: GoogleFonts.montserratAlternates(
                  color: SharedColor.COLOR_BLACK_400,
                  fontSize: ConstantFontSize.FONT_SIZE_16_0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.45),
              textAlign: TextAlign.right,
            ),
          ),
          body: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoadingState) {
                return ListView(
                  children: <Widget>[
                    Container(
                      color: SharedColor.COLOR_BLACK_200,
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    SizedBox(height: ConstantSpace.SPACE_4),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: ConstantSpace.SPACE_2_5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _headerTextField(AppLocalizations.of(context)
                              .translate('account_full_name')),
                          SizedBox(height: ConstantSpace.SPACE_1),
                          Container(
                            decoration: BoxDecoration(
                              color: SharedColor.COLOR_BLACK_200,
                              borderRadius:
                                  BorderRadius.circular(ConstantSpace.SPACE_3),
                            ),
                            height: ConstantSpace.SPACE_6_2_5,
                          ),
                          SizedBox(height: ConstantSpace.SPACE_2),
                          _headerTextField(AppLocalizations.of(context)
                              .translate('account_email')),
                          SizedBox(height: ConstantSpace.SPACE_1),
                          Container(
                            decoration: BoxDecoration(
                              color: SharedColor.COLOR_BLACK_200,
                              borderRadius:
                                  BorderRadius.circular(ConstantSpace.SPACE_3),
                            ),
                            height: ConstantSpace.SPACE_6_2_5,
                          ),
                          SizedBox(height: ConstantSpace.SPACE_4),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: SharedColor.COLOR_BLACK_200,
                                  shape: BoxShape.circle),
                              width: ConstantSpace.SPACE_5 * 2,
                              height: ConstantSpace.SPACE_5 * 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              if (state is UserLoadedState) {
                _nameController.text = state.user.name;
                _emailController.text = state.user.email;
                _markers.add(Marker(
                  markerId: MarkerId(state.user.id),
                  position: LatLng(
                    state.user.addressLatitude,
                    state.user.addressLongitude,
                  ),
                  icon: BitmapDescriptor.defaultMarker,
                ));
                return ListView(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: BlocBuilder<GoogleMapCubit, GoogleMapState>(
                        builder: (context, state) {
                          return GoogleMap(
                            myLocationEnabled: false,
                            compassEnabled: false,
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                App.main.user.addressLatitude,
                                App.main.user.addressLongitude,
                              ),
                              zoom: 14,
                            ),
                            markers: _markers,
                            onMapCreated: (GoogleMapController controller) {
                              context.bloc<GoogleMapCubit>().controller =
                                  controller;
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: ConstantSpace.SPACE_4),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: ConstantSpace.SPACE_2_5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _headerTextField(AppLocalizations.of(context)
                              .translate('account_full_name')),
                          SizedBox(height: ConstantSpace.SPACE_1),
                          CustomTextField(
                            isReadOnly: true,
                            hint: AppLocalizations.of(context)
                                .translate('account_email'),
                            textEditingController: _nameController,
                          ),
                          SizedBox(height: ConstantSpace.SPACE_2),
                          _headerTextField(AppLocalizations.of(context)
                              .translate('account_email')),
                          SizedBox(height: ConstantSpace.SPACE_1),
                          CustomTextField(
                            isReadOnly: true,
                            hint: AppLocalizations.of(context)
                                .translate('account_email'),
                            textEditingController: _emailController,
                          ),
                          SizedBox(height: ConstantSpace.SPACE_4),
                          Align(
                            alignment: Alignment.center,
                            child: ButtonTheme(
                              minWidth: ConstantSpace.SPACE_5 * 2,
                              height: ConstantSpace.SPACE_5 * 2,
                              child: FlatButton(
                                color: SharedColor.COLOR_YELLOW_400,
                                shape: CircleBorder(),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => UpdateProfilePage(
                                      user:
                                          (_userCubit.state as UserLoadedState)
                                              .user,
                                    ),
                                  ),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: SharedColor.COLOR_BLACK_100,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _headerTextField(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: ConstantSpace.SPACE_1),
      child: Text(
        text,
        style: GoogleFonts.montserratAlternates(
            color: SharedColor.COLOR_BLACK_400,
            fontSize: ConstantFontSize.FONT_SIZE_12_0,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.45),
        textAlign: TextAlign.left,
      ),
    );
  }
}
