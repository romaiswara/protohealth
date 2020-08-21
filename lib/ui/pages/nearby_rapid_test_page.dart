part of 'pages.dart';

class NearByRapidTestPage extends StatelessWidget {
  final LatLng latlng;
  final String city;

  NearByRapidTestPage({
    this.latlng,
    this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate('home_rapid_location'),
          style: GoogleFonts.montserratAlternates(
              color: SharedColor.COLOR_BLACK_400,
              fontSize: ConstantFontSize.FONT_SIZE_16_0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.45),
          textAlign: TextAlign.right,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.only(
            left: ConstantSpace.SPACE_3,
            right: ConstantSpace.SPACE_3,
            top: ConstantSpace.SPACE_4,
            bottom: ConstantSpace.SPACE_4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListNearbyRapidTest(
                list: listLocationTestCovid(
                  lat: latlng.latitude,
                  lng: latlng.longitude,
                  city: city,
                ),
                fromHome: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
