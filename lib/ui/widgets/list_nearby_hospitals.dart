part of 'widgets.dart';

class ListNearbyHospitals extends StatelessWidget {
  final List<HospitalModel> list;

  const ListNearbyHospitals({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverFillRemaining(
          hasScrollBody: true,
          child: ListView.separated(
            padding:  EdgeInsets.symmetric(
              horizontal: ConstantSpace.SPACE_3,
              vertical: ConstantSpace.SPACE_3,
            ),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => ItemLIstHospital(
              hospitalModel: list[index],
              bodyBottomshet:
                  _containerOnModalBottomSheet(context, list[index], false),
            ),
            separatorBuilder: (context, index) =>
                SizedBox(height: ConstantSpace.SPACE_3),
            itemCount: list.length,
          ),
        )
      ],
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
