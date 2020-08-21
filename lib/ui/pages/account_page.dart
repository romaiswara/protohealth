part of 'pages.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AuthCubit _authCubit = AuthCubit();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocProvider<AuthCubit>(
      create: (context) => _authCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthWaitingDataState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ConstantSpace.SPACE_2)),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: ConstantSpace.SPACE_2_5,
                      width: ConstantSpace.SPACE_2_5,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        backgroundColor: SharedColor.COLOR_GREEN_500,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            SharedColor.COLOR_PRIMARY),
                      ),
                    ),
                    SizedBox(width: ConstantSpace.SPACE_2),
                    Text(
                      AppLocalizations.of(context)
                          .translate('general_please_wait'),
                      style: GoogleFonts.montserratAlternates(
                          color: SharedColor.COLOR_BLACK_400,
                          fontSize: ConstantFontSize.FONT_SIZE_14_0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.45),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is AuthLoadedState) {
            if (state.user != null) {
              await context.bloc<LocalDataCubit>().saveUser(
                    repository: UserRepository(),
                    user: state.user,
                  );

              // listen history
              await context.bloc<HistoryCubit>().getHistoryCubit(state.user.id);

              if (state.user.identifier == null) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => UpdateProfilePage(
                            user: state.user,
                          )),
                  (route) => false,
                );
              } else {
                // check distance current location with home location
                double distanceInMeters = await Geolocator().distanceBetween(
                  state.user.addressLatitude,
                  state.user.addressLongitude,
                  App.main.lastLocation.latitude,
                  App.main.lastLocation.longitude,
                );
                // set status value
                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (distanceInMeters > 1000) {
                  await prefs.setInt('status', 1);
                } else {
                  await prefs.setInt('status', 2);
                }

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => DashboardPage(
                            selectedIndex: 4,
                          )),
                  (route) => false,
                );
              }
            } else {
              await context
                  .bloc<LocalDataCubit>()
                  .clearUser(repository: UserRepository());

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => DashboardPage(
                          selectedIndex: 4,
                        )),
                (route) => false,
              );
            }
          }
          if (state is AuthFailureState) {
            showDialogError(
              context: context,
              message: state.errorMessage,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              AppLocalizations.of(context).translate('menu_account'),
              style: GoogleFonts.montserratAlternates(
                  color: SharedColor.COLOR_BLACK_400,
                  fontSize: ConstantFontSize.FONT_SIZE_16_0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.45),
              textAlign: TextAlign.right,
            ),
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: ConstantSpace.SPACE_2),
              BlocBuilder<LocalDataCubit, LocalDataState>(
                builder: (context, state) {
                  return _buildItemContent(
                    width,
                    (state as LocalDataLoadedState).user == null
                        ? AppLocalizations.of(context)
                            .translate('account_login')
                        : AppLocalizations.of(context)
                            .translate('account_profile'),
                    Icons.person,
                    (state as LocalDataLoadedState).user == null
                        ? () => _authCubit.signIn()
                        : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                  id: (state as LocalDataLoadedState).user.id,
                                ),
                              ),
                            ),
                  );
                },
              ),
              SizedBox(height: ConstantSpace.SPACE_2),
              _buildItemContent(
                width,
                AppLocalizations.of(context).translate('account_language'),
                Icons.info,
                () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LanguagePage()),
                ),
              ),
              SizedBox(height: ConstantSpace.SPACE_2),
              _buildItemContent(
                  width,
                  AppLocalizations.of(context).translate('account_about_us'),
                  Icons.info,
                  () => CommonsWidget().snackBar(context,
                      "${AppLocalizations.of(context).translate('account_about_us')} soon")),
              SizedBox(height: ConstantSpace.SPACE_2),
              _buildItemContent(
                  width,
                  AppLocalizations.of(context)
                      .translate('account_term_conditions'),
                  Icons.insert_drive_file,
                  () => CommonsWidget().snackBar(context,
                      "${AppLocalizations.of(context).translate('account_term_conditions')} soon")),
              SizedBox(height: ConstantSpace.SPACE_2),
              _buildItemContent(
                  width,
                  AppLocalizations.of(context).translate('account_faqs'),
                  Icons.help,
                  () => CommonsWidget().snackBar(context,
                      "${AppLocalizations.of(context).translate('account_faqs')} soon")),
              SizedBox(height: ConstantSpace.SPACE_2),
              BlocBuilder<LocalDataCubit, LocalDataState>(
                builder: (context, state) {
                  if (state is LocalDataLoadedState) {
                    if (state.user != null) {
                      return _buildItemContent(
                          width,
                          AppLocalizations.of(context)
                              .translate('account_logout'),
                          Icons.person,
                          () => _authCubit.signOut());
                    }
                  }
                  return SizedBox();
                },
              ),
              SizedBox(height: ConstantSpace.SPACE_2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemContent(
      double width, String text, IconData icon, Function onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ConstantSpace.SPACE_2_5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ConstantSpace.SPACE_3,
            vertical: ConstantSpace.SPACE_2_2_5,
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: ConstantSpace.SPACE_4_5,
                width: ConstantSpace.SPACE_4_5,
                child: CircleAvatar(
                  backgroundColor: SharedColor.COLOR_YELLOW_400,
                  foregroundColor: SharedColor.COLOR_GREEN_500,
                  child: Icon(
                    icon,
                    color: SharedColor.COLOR_PRIMARY,
                  ),
                ),
              ),
              SizedBox(width: ConstantSpace.SPACE_2_2_5),
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.montserratAlternates(
                      color: SharedColor.COLOR_BLACK_400,
                      fontSize: ConstantFontSize.FONT_SIZE_14_0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConstantSpace.SPACE_4_5),
            color: SharedColor.COLOR_BLACK_50,
            boxShadow: [
              BoxShadow(
                color: SharedColor.COLOR_BLACK_200,
                spreadRadius: 0,
                blurRadius: 7,
                offset: Offset(2, 8),
              ),
            ],
          ),
          width: width,
        ),
      ),
    );
  }
}
