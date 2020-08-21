part of 'pages.dart';

class DashboardPage extends StatefulWidget {
  final int selectedIndex;

  const DashboardPage({Key key, this.selectedIndex = 0}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final NotificationCubit _notificationCubit = NotificationCubit();
  final HistoryCubit _historyCubit = HistoryCubit();
  final LocationDeviceCubit _locationDeviceCubit = LocationDeviceCubit();
  final Logger logger = Logger('Dashboard Page');
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  int _selectedTabIndex;

  List _pages = [
    HomePage(
      key: PageStorageKey('HomePage'),
    ),
    HospitalsPage(
      key: PageStorageKey('HospitalsPage'),
    ),
    HistoryPage(
      key: PageStorageKey('HistoryPage'),
    ),
    NotificationPage(
      key: PageStorageKey('NotificationPage'),
    ),
    AccountPage(
      key: PageStorageKey('AccountPage'),
    ),
  ];

  void _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = widget.selectedIndex;
    firebaseMessaging.subscribeToTopic('TRY_FCM');
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        Logger('On Message').fine('Message: ${message.toString()}');
        NotificationModel notificationModel =
            NotificationModel.fromJson(message);
        Logger('On Message')
            .fine('Notification: ${notificationModel.toString()}');

        // show flushbar
        Flushbar(
          flushbarStyle: FlushbarStyle.FLOATING,
          messageText: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                notificationModel.status.contains("1")
                    ? AppLocalizations.of(context).translate('notif_header_out')
                    : AppLocalizations.of(context).translate('notif_header_in'),
                style: GoogleFonts.kodchasan(
                    color: SharedColor.COLOR_PRIMARY,
                    fontSize: ConstantFontSize.FONT_SIZE_14_0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5),
                textAlign: TextAlign.left,
              ),
              Text(
                notificationModel.status.contains("1")
                    ? AppLocalizations.of(context)
                        .translate('notif_content_out')
                    : AppLocalizations.of(context)
                        .translate('notif_content_in'),
                style: GoogleFonts.kodchasan(
                    color: SharedColor.COLOR_PRIMARY,
                    fontSize: ConstantFontSize.FONT_SIZE_13_0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          backgroundColor: SharedColor.COLOR_YELLOW_400,
          flushbarPosition: FlushbarPosition.TOP,
          margin: EdgeInsets.all(ConstantSpace.SPACE_2),
          padding: EdgeInsets.symmetric(
              horizontal: ConstantSpace.SPACE_3,
              vertical: ConstantSpace.SPACE_2_5),
          icon: Container(
              height: ConstantSpace.SPACE_4,
              width: ConstantSpace.SPACE_4,
              child: Image.asset(notificationModel.status.contains("1")
                  ? 'assets/icons/out.png'
                  : 'assets/icons/in.png')),
          isDismissible: false,
          animationDuration: Duration(milliseconds: 500),
          duration: Duration(seconds: 3),
          borderRadius: ConstantSpace.SPACE_2,
        )..show(context);
      },
      onBackgroundMessage: onBackgroundMessage,
      onResume: (Map<String, dynamic> message) async {
        GetNotification(from: 'On Resume', message: message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        GetNotification(from: 'On Launch', message: message);
      },
    );
    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: true),
    );
    firebaseMessaging.onIosSettingsRegistered.listen((settings) {
      Logger('Settings').fine(settings.toString());
    });
    firebaseMessaging.getToken().then((token) {
      Logger('Token Firebase').fine(token);
      App.main.firebaseToken = token;
    });
  }

  void GetNotification({String from, Map<String, dynamic> message}) {
    Logger(from).fine('Message: ${message.toString()}');
  }

  void checkDistanceLocation(double latitude, double longitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt('status') ?? 0;

    UserRepository userRepository = UserRepository();
    User user = await userRepository.loadLocal();
    if (user != null && user.reminder.contains(ConstantString.ENABLED)) {
      // get distance
      double distanceInMeters = await Geolocator().distanceBetween(
          user.addressLatitude, user.addressLongitude, latitude, longitude);

      if (distanceInMeters > 1000 && value != 1) {
        Logger('checkDistanceLocation')
            .fine('ROMAISWARA distanceInMeters > 1000 && value != 1');

        // SET VALUE TO 1
        await prefs.setInt('status', 1);
        // SEND NOTIF KELUAR
        _notificationCubit.sendNotificationWithHttp(
          user: App.main.user,
          body: AppLocalizations.of(context).translate('notif_content_out'),
          status: '1',
        );

        // add history
        _historyCubit.addHistory(userId: App.main.user.id, status: '1');
      } else if (distanceInMeters <= 1000 && value != 2) {
        Logger('checkDistanceLocation')
            .fine('distanceInMeters <= 1000 && value != 2');

        // SET VALUE TO 2
        await prefs.setInt('status', 2);
        // SEND NOTIF MASUK
        _notificationCubit.sendNotificationWithHttp(
          user: App.main.user,
          body: AppLocalizations.of(context).translate('notif_content_in'),
          status: '2',
        );

        // add history
        _historyCubit.addHistory(userId: App.main.user.id, status: '2');
      } else {
        Logger('checkDistanceLocation')
            .fine('LAINNYA distance: $distanceInMeters, value: $value');
        // DO NOTHING
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// FOR PERMISSION LOCATION
        BlocProvider<LocationPermissionCubit>(
          create: (_) => LocationPermissionCubit()..checkLocationPermission(),
        ),

        /// FOR CURRENT LOCATION
        BlocProvider<LocationDeviceCubit>(
          create: (_) => _locationDeviceCubit,
        ),

        /// FOR NOTIFICATION
        BlocProvider<NotificationCubit>(
          create: (_) => _notificationCubit,
        ),

        /// FOR CONNECTION
        BlocProvider<ConnectionCubit>(
          create: (_) => ConnectionCubit(),
        ),

        BlocProvider<UserCubit>(
          create: (_) => UserCubit(),
        ),

        BlocProvider<HistoryCubit>(
          create: (_) => _historyCubit,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<LocationPermissionCubit, LocationPermissionState>(
            listener: (context, state) {
              logger.fine('LocationPermissionState ${state.toString()}');
              if (state is LocationPermissionSucceededState) {
//                _locationDeviceCubit.getCurrentLocation();
                _locationDeviceCubit.listenLocation();
              }
            },
          ),
          BlocListener<LocationDeviceCubit, LocationDeviceState>(
            listener: (context, state) {
              logger.fine('LocationDeviceCubit ${state.toString()}');
              if (state is LocationDeviceLoadedState) {
                // save value to global variable
                App.main.lastLocation = LatLng(state.latitude, state.longitude);

                checkDistanceLocation(state.latitude, state.longitude);
              }
            },
          ),
          BlocListener<UserCubit, UserState>(
            listener: (context, state) {
              logger.fine('UserCubit ${state.toString()}');
              if (state is UserLoadedState) {
                App.main.user = state.user;
                setState(() {});
              }
            },
          ),
          BlocListener<HistoryCubit, HistoryState>(
            listener: (context, state) {
              logger.fine('History Cubit STATE ${state.toString()}');
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
          body: Center(child: _pages[_selectedTabIndex]),
          bottomNavigationBar: BottomNavigationBar(
            iconSize: 24,
            unselectedItemColor: SharedColor.COLOR_BLACK_300,
            selectedItemColor: SharedColor.COLOR_GREEN_500,
            currentIndex: _selectedTabIndex,
            onTap: _changeIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  AppLocalizations.of(context).translate('menu_home'),
                  style: GoogleFonts.montserratAlternates(
                      fontSize: ConstantFontSize.FONT_SIZE_12_0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital),
                title: Text(
                  AppLocalizations.of(context).translate('menu_hospital'),
                  style: GoogleFonts.montserratAlternates(
                      fontSize: ConstantFontSize.FONT_SIZE_12_0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                title: Text(
                  AppLocalizations.of(context).translate('menu_history'),
                  style: GoogleFonts.montserratAlternates(
                      fontSize: ConstantFontSize.FONT_SIZE_12_0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none),
                title: Text(
                  AppLocalizations.of(context).translate('menu_notification'),
                  style: GoogleFonts.montserratAlternates(
                      fontSize: ConstantFontSize.FONT_SIZE_12_0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text(
                  AppLocalizations.of(context).translate('menu_account'),
                  style: GoogleFonts.montserratAlternates(
                      fontSize: ConstantFontSize.FONT_SIZE_12_0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) {
    Logger('On Background Message').fine('Message: $message');
    if (message.containsKey('data')) {
      NotificationModel notificationModel = NotificationModel.fromJson(message);
      Logger('On Background Message')
          .fine('Notification: ${notificationModel.toString()}');
    }
    return null;
  }
}
