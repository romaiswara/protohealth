part of 'pages.dart';

class UpdateProfilePage extends StatefulWidget {
  final User user;

  UpdateProfilePage({
    this.user,
  });

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  final Logger logger = Logger('Auth Service');
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name ?? '';
    _emailController.text = widget.user.email;
    latitude = widget.user.addressLatitude;
    longitude = widget.user.addressLongitude;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        /// FOR CONNECTION
        BlocProvider<ConnectionCubit>(
          create: (_) => ConnectionCubit(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<LocalDataCubit, LocalDataState>(
            listener: (context, state) {
              if (state is LocalDataFailureState) {
                showDialogError(
                  context: context,
                  message: state.errorMessage,
                );
              }
              if (state is LocalDataLoadedState) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => DashboardPage(),
                  ),
                  (route) => false,
                );
              }
            },
          ),
          BlocListener<ConnectionCubit, ConnectionInternetState>(
            listener: (context, state) {
              if (state is NoConnectionState) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NoInternetPage()),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: SharedColor.COLOR_BLACK_100,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              AppLocalizations.of(context).translate('account_profile'),
              style: GoogleFonts.montserratAlternates(
                  color: SharedColor.COLOR_BLACK_400,
                  fontSize: ConstantFontSize.FONT_SIZE_16_0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.45),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: ConstantSpace.SPACE_2_5),
            children: <Widget>[
              SizedBox(height: ConstantSpace.SPACE_2),
              _headerTextField(
                  AppLocalizations.of(context).translate('account_full_name')),
              SizedBox(height: ConstantSpace.SPACE_1),
              CustomTextField(
                isReadOnly: false,
                hint:
                    AppLocalizations.of(context).translate('account_full_name'),
                textEditingController: _nameController,
              ),
              SizedBox(height: ConstantSpace.SPACE_2),
              _headerTextField(
                  AppLocalizations.of(context).translate('account_email')),
              SizedBox(height: ConstantSpace.SPACE_1),
              CustomTextField(
                isReadOnly: true,
                hint: AppLocalizations.of(context).translate('account_email'),
                textEditingController: _emailController,
              ),
              SizedBox(height: ConstantSpace.SPACE_2),
              _headerTextField(
                  AppLocalizations.of(context).translate('account_location')),
              SizedBox(height: ConstantSpace.SPACE_1),
              _button(
                true,
                ConstantSpace.SPACE_6,
                width,
                AppLocalizations.of(context)
                    .translate('account_set_home_location'),
                () => Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => SelectAddressMapsPage()))
                    .then(
                  (value) {
                    if (value != null) {
                      setState(() {
                        latitude = (value as LatLng).latitude;
                        longitude = (value as LatLng).longitude;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
          bottomSheet: Container(
            color: SharedColor.COLOR_BLACK_100,
            padding: const EdgeInsets.all(ConstantSpace.SPACE_2),
            child: _button(
              false,
              ConstantSpace.SPACE_6,
              width,
              AppLocalizations.of(context).translate('general_save'),
              (latitude == null)
                  ? null
                  : () {
                      context.bloc<LocalDataCubit>().updateUser(
                            sessionRepository: SessionRepository(),
                            userRepository: UserRepository(),
                            id: widget.user.id,
                            email: widget.user.email,
                            name: _nameController.text,
                            latitude: latitude,
                            longitude: longitude,
                            reminder: ConstantString.ENABLED,
                          );
                    },
            ),
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

  Widget _button(bool isUsedIcon, double height, double width, String text,
      Function ontap) {
    return Container(
      width: width,
      child: ButtonTheme(
        height: height,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConstantSpace.SPACE_3),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: ConstantSpace.SPACE_2,
          vertical: ConstantSpace.SPACE_1_5,
        ),
        buttonColor: !isUsedIcon
            ? SharedColor.COLOR_YELLOW_500
            : SharedColor.COLOR_GREEN_400,
        child: RaisedButton(
          child: isUsedIcon
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      color: SharedColor.COLOR_PRIMARY,
                    ),
                    SizedBox(width: ConstantSpace.SPACE_1),
                    Text(
                      text,
                      style: GoogleFonts.montserratAlternates(
                          letterSpacing: 0.8,
                          fontSize: ConstantFontSize.FONT_SIZE_14_0,
                          fontWeight: FontWeight.w500,
                          color: SharedColor.COLOR_PRIMARY),
                    ),
                  ],
                )
              : Text(
                  text,
                  style: GoogleFonts.montserratAlternates(
                      letterSpacing: 0.8,
                      fontSize: ConstantFontSize.FONT_SIZE_14_0,
                      fontWeight: FontWeight.w500,
                      color: SharedColor.COLOR_PRIMARY),
                ),
          elevation: 0,
          onPressed: ontap,
        ),
      ),
    );
  }
}
