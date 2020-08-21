part of 'pages.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  // state to handle the movement of dots
  int currentPage = 0;

  final List<Widget> onBoardingPages = <Widget>[
    _ContentPage(
      image: Image.asset('assets/images/on_boarding_1.png'),
      title: 'onboarding_1_title',
      description: 'onboarding_1_desc',
    ),
    _ContentPage(
      image: Image.asset('assets/images/on_boarding_2.png'),
      title: 'onboarding_2_title',
      description: 'onboarding_2_desc',
    ),
    _ContentPage(
      image: Image.asset('assets/images/on_boarding_3.png'),
      title: 'onboarding_3_title',
      description: 'onboarding_3_desc',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationPermissionCubit>(
      create: (_) => LocationPermissionCubit()..checkLocationPermission(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            PageView(
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              scrollDirection: Axis.horizontal,
              children: onBoardingPages,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: DotsIndicator(
                      dotsCount: onBoardingPages.length,
                      position: currentPage.toDouble(),
                      decorator: DotsDecorator(
                        size: Size.square(5),
                        activeSize: Size.square(9),
                        color: Colors.amber[200],
                        activeColor: Colors.amber,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: FlatButton(
                      highlightColor: Colors.yellow[100],                      
                      splashColor: Colors.amber,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => DashboardPage()),
                        );
                      },
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('onboarding_get_started'),
                        style: GoogleFonts.montserratAlternates(
                        color: SharedColor.COLOR_YELLOW_500,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.6),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ContentPage extends StatelessWidget {
  /// Asset image with predefined width or size
  final Widget image;
  final String title;
  final String description;

  _ContentPage({
    @required this.image,
    @required this.title,
    @required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  alignment: Alignment.center,
                  child: image,
                ),
                SizedBox(height: 60),
                Text(
                  AppLocalizations.of(context).translate(title),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserratAlternates(
                    color: SharedColor.COLOR_BLACK_400,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.6),
                ),
                SizedBox(height: 12),
                Text(
                  AppLocalizations.of(context).translate(description),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserratAlternates(
                    color: SharedColor.COLOR_BLACK_300,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.6),
                ),
              ],
            ),
          ),          
        ],
      ),
    );
  }
}
