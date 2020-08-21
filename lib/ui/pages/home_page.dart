part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final NotificationCubit _notificationCubit =
        context.bloc<NotificationCubit>();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(
                left: ConstantSpace.SPACE_4,
                right: ConstantSpace.SPACE_4,
                top: ConstantSpace.SPACE_6,
                bottom: ConstantSpace.SPACE_6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: ConstantSpace.SPACE_1),
                _headerPageWidget(context, width, height),
                SizedBox(height: ConstantSpace.SPACE_3),
                // . TODO DELETE. ONLY FOR TEST NOTIF
//                BlocBuilder<LocalDataCubit, LocalDataState>(
//                  builder: (context, state) {
//                    if (state is LocalDataLoadedState && state.user != null) {
//                      return Column(
//                        children: <Widget>[
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            children: <Widget>[
//                              RaisedButton(
//                                onPressed: () {
//                                  print('GO OUT');
//                                  _notificationCubit.sendNotificationWithHttp(
//                                    user: App.main.user,
//                                    body: AppLocalizations.of(context)
//                                        .translate('notif_content_out'),
//                                    status: '1',
//                                  );
//                                },
//                                child: Text(
//                                  'Notif Go out',
//                                  style: TextStyle(
//                                    color: Colors.white,
//                                  ),
//                                ),
//                                color: Colors.red,
//                              ),
//                              RaisedButton(
//                                onPressed: () {
//                                  print('COME IN');
//                                  _notificationCubit.sendNotificationWithHttp(
//                                    user: App.main.user,
//                                    body: AppLocalizations.of(context)
//                                        .translate('notif_content_in'),
//                                    status: '2',
//                                  );
//                                },
//                                child: Text(
//                                  'Notif Come in',
//                                  style: TextStyle(
//                                    color: Colors.white,
//                                  ),
//                                ),
//                                color: Colors.green,
//                              ),
//                            ],
//                          ),
//                          SizedBox(height: ConstantSpace.SPACE_5),
//                        ],
//                      );
//                    }
//                    return SizedBox();
//                  },
//                ),
                _activateReminderWidget(context, width),
                SizedBox(height: ConstantSpace.SPACE_4),
                _headerContentWidget(
                  context,
                  AppLocalizations.of(context).translate('home_latest_Case'),
                  UpdateCovidPage(),
                ),
                SizedBox(height: ConstantSpace.SPACE_0_5),
                _updateCase(),
                SizedBox(height: ConstantSpace.SPACE_3),
                BlocBuilder<LocationDeviceCubit, LocationDeviceState>(
                  builder: (context, state) {
                    if (state is LocationDeviceLoadingState) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: ConstantSpace.SPACE_0_5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                LoaderText(
                                    height: ConstantSpace.SPACE_2,
                                    widthPercentage: 0.5),
                                LoaderText(
                                  height: ConstantSpace.SPACE_1_5,
                                  widthPercentage: 0.1,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: ConstantSpace.SPACE_3),
                          LoaderListNearbyRapidTest(
                            listCount: 3,
                          )
                        ],
                      );
                    }
                    if (state is LocationDeviceLoadedState) {
                      return Column(
                        children: [
                          _headerContentWidget(
                            context,
                            AppLocalizations.of(context)
                                .translate('home_rapid_location'),
                            NearByRapidTestPage(
                              latlng: LatLng(
                                state.latitude,
                                state.longitude,
                              ),
                              city: state.city,
                            ),
                          ),
                          SizedBox(height: ConstantSpace.SPACE_3),
                          ListNearbyRapidTest(
                            list: listLocationTestCovid(
                              lat: state.latitude,
                              lng: state.longitude,
                              city: state.city,
                            ),
                            fromHome: true,
                          ),
                        ],
                      );
                    }
                    return SizedBox();
                  },
                ),
                SizedBox(height: ConstantSpace.SPACE_5),
                BlocBuilder<LocationDeviceCubit, LocationDeviceState>(
                  builder: (context, state) {
                    if (state is LocationDeviceLoadingState) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: ConstantSpace.SPACE_0_5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                LoaderText(
                                    height: ConstantSpace.SPACE_2,
                                    widthPercentage: 0.5),
                                LoaderText(
                                  height: ConstantSpace.SPACE_1_5,
                                  widthPercentage: 0.1,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: ConstantSpace.SPACE_3),
                          LoaderListNearbyPharmacy(
                            listCount: 3,
                          )
                        ],
                      );
                    }
                    if (state is LocationDeviceLoadedState) {
                      return Column(
                        children: [
                          _headerContentWidget(
                            context,
                            AppLocalizations.of(context)
                                .translate('home_pharmacy_nearby'),
                            NearByPharmacyPage(
                              latlng: LatLng(
                                state.latitude,
                                state.longitude,
                              ),
                              city: state.city,
                            ),
                          ),
                          SizedBox(height: ConstantSpace.SPACE_3),
                          ListNearbyPharmacy(
                            list: listPharmacy(
                              lat: state.latitude,
                              lng: state.longitude,
                              city: state.city,
                            ),
                            fromHome: true,
                          ),
                        ],
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///widget header page
  Widget _headerPageWidget(BuildContext context, double width, double height) {
    return BlocBuilder<LocalDataCubit, LocalDataState>(
      builder: (context, state) {
        if (state is LocalDataLoadedState) {
          return Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: ConstantSpace.SPACE_0_5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Halo, ',
                            style: GoogleFonts.montserratAlternates(
                                color: SharedColor.COLOR_BLACK_400,
                                fontSize: 28,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5),
                          ),
                          Text(
                            (state.user == null)
                                ? AppLocalizations.of(context)
                                    .translate('home_guest')
                                : '${state.user.name}',
                            style: GoogleFonts.montserratAlternates(
                                color: SharedColor.COLOR_BLACK_500,
                                fontSize: ConstantFontSize.FONT_SIZE_22_0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.45),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ConstantSpace.SPACE_0_5),
                    BlocBuilder<LocationDeviceCubit, LocationDeviceState>(
                      builder: (context, state) {
                        if (state is LocationDeviceLoadingState){
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: SharedColor.COLOR_YELLOW_400,
                                size: ConstantFontSize.FONT_SIZE_24_0,
                              ),
                              SizedBox(width: ConstantSpace.SPACE_0_5),
                              LoaderText(
                                height: ConstantSpace.SPACE_2, 
                                widthPercentage: 0.4,
                              ),
                            ],
                          );
                        }
                        if (state is LocationDeviceLoadedState) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: SharedColor.COLOR_YELLOW_400,
                                size: ConstantFontSize.FONT_SIZE_24_0,
                              ),
                              SizedBox(width: ConstantSpace.SPACE_0_5),
                              Expanded(
                                child: Text(
                                  state.city ?? '',
                                  style: GoogleFonts.montserratAlternates(
                                      color: SharedColor.COLOR_BLACK_400,
                                      fontSize: ConstantFontSize.FONT_SIZE_16_0,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.45),
                                ),
                              ),
                            ],
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }

  Widget _activateReminderWidget(BuildContext context, double width) {
    return BlocBuilder<LocalDataCubit, LocalDataState>(
      builder: (context, state) {
        if (state is LocalDataLoadedState) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: ConstantSpace.SPACE_4,
              vertical: ConstantSpace.SPACE_2_5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ConstantSpace.SPACE_4),
              color: SharedColor.COLOR_BLACK_50,
              boxShadow: [
                BoxShadow(
                  color: SharedColor.COLOR_BLACK_200,
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(2, 8),
                ),
              ],
            ),
            width: width,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    (state.user != null)
                        ? (state.user.reminder.contains(ConstantString.ENABLED))
                            ? AppLocalizations.of(context)
                                .translate('home_disable_reminder')
                            : AppLocalizations.of(context)
                                .translate('home_enable_reminder')
                        : AppLocalizations.of(context)
                            .translate('home_info_reminder'),
                    style: GoogleFonts.montserratAlternates(
                        color: SharedColor.COLOR_BLACK_400,
                        fontSize: ConstantFontSize.FONT_SIZE_14_0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(width: ConstantSpace.SPACE_1),
                ButtonTheme(
                  minWidth: width * 0.125,
                  height: width * 0.1,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ConstantSpace.SPACE_2_2_5)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: ConstantSpace.SPACE_2,
                    vertical: ConstantSpace.SPACE_1_5,
                  ),
                  buttonColor: SharedColor.COLOR_RED_500,
                  child: RaisedButton(
                    child: Text(
                        (state.user != null)
                            ? (state.user.reminder
                                    .contains(ConstantString.ENABLED))
                                ? AppLocalizations.of(context)
                                    .translate('home_disable')
                                : AppLocalizations.of(context)
                                    .translate('home_enable')
                            : AppLocalizations.of(context)
                                .translate('home_info'),
                        style: GoogleFonts.montserratAlternates(
                            color: SharedColor.COLOR_PRIMARY,
                            fontSize: ConstantFontSize.FONT_SIZE_14_0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.6)),
                    elevation: 0,
                    onPressed: () => CommonsWidget().showModalSheet(
                        body: Container(
                          padding: EdgeInsets.only(
                              left: ConstantSpace.SPACE_3,
                              right: ConstantSpace.SPACE_3,
                              bottom: ConstantSpace.SPACE_3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('home_agreement_reminder'),
                                  style: GoogleFonts.montserratAlternates(
                                      letterSpacing: 0.8,
                                      fontSize: ConstantFontSize.FONT_SIZE_13_0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: ConstantSpace.SPACE_3,
                              ),
                              Text(
                                (state.user != null &&
                                        (state.user.reminder
                                            .contains(ConstantString.ENABLED)))
                                    ? AppLocalizations.of(context)
                                        .translate('home_agreement_p1_disable')
                                    : AppLocalizations.of(context)
                                        .translate('home_agreement_p1'),
                                style: GoogleFonts.montserratAlternates(
                                    letterSpacing: 0.4,
                                    fontSize: ConstantFontSize.FONT_SIZE_13_0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: ConstantSpace.SPACE_1_5,
                              ),
                              if (state.user == null) ...[
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('home_agreement_p2'),
                                  style: GoogleFonts.montserratAlternates(
                                      letterSpacing: 0.4,
                                      fontSize: ConstantFontSize.FONT_SIZE_13_0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: ConstantSpace.SPACE_3,
                                ),
                              ],
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  ButtonTheme(
                                    minWidth: width * 0.275,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            ConstantSpace.SPACE_2_5),
                                        side: BorderSide(
                                            color: SharedColor.COLOR_YELLOW_400,
                                            width: 1)),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: ConstantSpace.SPACE_2,
                                      vertical: ConstantSpace.SPACE_1_5,
                                    ),
                                    buttonColor: Colors.white,
                                    child: RaisedButton(
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate('general_cancel'),
                                        style: TextStyle(
                                            letterSpacing: 0.8,
                                            fontSize:
                                                ConstantFontSize.FONT_SIZE_14_0,
                                            fontWeight: FontWeight.w600,
                                            color: SharedColor.COLOR_YELLOW_400),
                                        textAlign: TextAlign.left,
                                      ),
                                      elevation: 0,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  ButtonTheme(
                                    minWidth: width * 0.275,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          ConstantSpace.SPACE_2_5),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: ConstantSpace.SPACE_2,
                                      vertical: ConstantSpace.SPACE_1_5,
                                    ),
                                    buttonColor: SharedColor.COLOR_YELLOW_400,
                                    child: RaisedButton(
                                      child: Text(
                                        (state.user != null)
                                            ? (state.user.reminder.contains(
                                                    ConstantString.ENABLED))
                                                ? AppLocalizations.of(context)
                                                    .translate('home_disable')
                                                : AppLocalizations.of(context)
                                                    .translate('home_enable')
                                            : AppLocalizations.of(context)
                                                .translate('account_login'),
                                        style: TextStyle(
                                            letterSpacing: 0.8,
                                            fontSize:
                                                ConstantFontSize.FONT_SIZE_14_0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        textAlign: TextAlign.left,
                                      ),
                                      elevation: 0,
                                      onPressed: () async {
                                        if (state.user != null) {
                                          String reminder;
                                          if (state.user.reminder.contains(
                                              ConstantString.ENABLED)) {
                                            reminder = ConstantString.DISABLED;
                                          } else {
                                            reminder = ConstantString.ENABLED;
                                          }
                                          await context
                                              .bloc<LocalDataCubit>()
                                              .saveUser(
                                                repository: UserRepository(),
                                                user: state.user.copyWith(
                                                  reminder: reminder,
                                                ),
                                              );
                                          Navigator.of(context).pop();
                                        } else {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DashboardPage(
                                                      selectedIndex: 4,
                                                    )),
                                            (route) => false,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        context: context),
                  ),
                )
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  ///header content widget
  Widget _headerContentWidget(
      BuildContext context, String header, Widget nextRoute) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ConstantSpace.SPACE_1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            header,
            style: GoogleFonts.montserratAlternates(
                color: SharedColor.COLOR_BLACK_500,
                fontSize: ConstantFontSize.FONT_SIZE_14_0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.6),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => nextRoute,
              ),
            ),
            child: Container(
              child: Text(
                AppLocalizations.of(context).translate('general_more'),
                style: GoogleFonts.montserratAlternates(
                    color: SharedColor.COLOR_BLACK_300,
                    fontSize: ConstantFontSize.FONT_SIZE_12_0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.6),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _updateCase() {
    return BlocProvider<CovidCubit>(
      create: (context) => CovidCubit()..getAllData(),
      child: BlocListener<CovidCubit, CovidState>(
        listener: (context, state) {
          if (state is CovidFailureState) {
            showDialogError(
              context: context,
              message: state.errorMessage,
            );
          }
        },
        child: BlocBuilder<CovidCubit, CovidState>(
          builder: (context, state) {
            if (state is CovidLoadingState) {
              return LoaderCovidUpdate();
            }
            if (state is CovidLoadedState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: ConstantSpace.SPACE_0_5),
                        child: Text(
                          'Indonesia, ',
                          style: GoogleFonts.montserratAlternates(
                              color: SharedColor.COLOR_BLACK_400,
                              fontSize: ConstantFontSize.FONT_SIZE_12_0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.6),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: ConstantSpace.SPACE_1),
                        child: Text(
                          '${state.covidUpdateTambah.tanggal}',
                          style: GoogleFonts.montserratAlternates(
                              color: SharedColor.COLOR_BLACK_400,
                              fontSize: ConstantFontSize.FONT_SIZE_12_0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.6),
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  GridView.count(
                    padding: EdgeInsets.symmetric(
                        horizontal: ConstantSpace.SPACE_2,
                        vertical: ConstantSpace.SPACE_3),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.55,
                    crossAxisCount: 2,
                    crossAxisSpacing: ConstantSpace.SPACE_2,
                    mainAxisSpacing: ConstantSpace.SPACE_2,
                    children: <Widget>[
                      _itemWrap(
                        AppLocalizations.of(context).translate('home_positive'),
                        state.covidUpdateTotal.jumlahPositif,
                        state.covidUpdateTambah.jumlahPositif,
                        SharedColor.COLOR_RED_500,
                      ),
                      _itemWrap(
                        AppLocalizations.of(context).translate('home_recover'),
                        state.covidUpdateTotal.jumlahSembuh.toString(),
                        state.covidUpdateTambah.jumlahSembuh.toString(),
                        SharedColor.COLOR_GREEN_500,
                      ),
                      _itemWrap(
                        AppLocalizations.of(context).translate('home_inpatient'),
                        state.covidUpdateTotal.jumlahDirawat.toString(),
                        state.covidUpdateTambah.jumlahDirawat.toString(),
                        SharedColor.COLOR_YELLOW_500,
                      ),
                      _itemWrap(
                        AppLocalizations.of(context).translate('home_died'),
                        state.covidUpdateTotal.jumlahMeninggal.toString(),
                        state.covidUpdateTambah.jumlahMeninggal.toString(),
                        SharedColor.COLOR_BLACK_300,
                      ),
                    ],
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _itemWrap(String text, data1, data2, Color color) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: ConstantSpace.SPACE_2_5, vertical: ConstantSpace.SPACE_2),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: SharedColor.COLOR_BLACK_200,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(2, 3),
          ),
        ],
        color: SharedColor.COLOR_BLACK_50,
        borderRadius: BorderRadius.circular(ConstantSpace.SPACE_2_5),
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Utility().formatNumber(data1),
                  style: GoogleFonts.montserratAlternates(
                      color: color,
                      fontSize: ConstantFontSize.FONT_SIZE_18_0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5),
                ),
                Text(
                  text,
                  style: GoogleFonts.montserratAlternates(
                      color: SharedColor.COLOR_BLACK_300,
                      fontSize: ConstantFontSize.FONT_SIZE_12_0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.add,
                  size: 12,
                  color: color,
                ),
                Text(
                  Utility().formatNumber(data2),
                  style: GoogleFonts.montserratAlternates(
                      color: color,
                      fontSize: ConstantFontSize.FONT_SIZE_14_0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
