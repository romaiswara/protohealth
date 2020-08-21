part of 'widgets.dart';

class ListNearbyRapidTest extends StatelessWidget {
  final List<LocationTestCovidModel> list;
  final bool fromHome;

  const ListNearbyRapidTest({
    Key key,
    this.list,
    this.fromHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count;
    if (fromHome) {
      count = (list.length > 3) ? 3 : list.length;
    } else {
      count = list.length;
    }
    final width = MediaQuery.of(context).size.width;    
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.only(
          top: ConstantSpace.SPACE_2,
          bottom: ConstantSpace.SPACE_1_5,
          left: ConstantSpace.SPACE_3,
          right: ConstantSpace.SPACE_1_5,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${list[index].name}',
                    style: GoogleFonts.montserratAlternates(
                        color: SharedColor.COLOR_BLACK_400,
                        fontSize: ConstantFontSize.FONT_SIZE_14_0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5),
                  ),
                  SizedBox(height: ConstantSpace.SPACE_0_5),
                  Text(
                    '${list[index].city}',
                    style: GoogleFonts.montserratAlternates(
                        color: SharedColor.COLOR_BLACK_300,
                        fontSize: ConstantFontSize.FONT_SIZE_12_0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5),
                  ),
                  SizedBox(height: ConstantSpace.SPACE_1),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: SharedColor.COLOR_YELLOW_400,
                        size: ConstantSpace.SPACE_2,
                      ),
                      SizedBox(width: ConstantSpace.SPACE_0_7_5),
                      Text(
                        '${list[index].distance} KM',
                        style: GoogleFonts.montserratAlternates(
                            color: SharedColor.COLOR_BLACK_400,
                            fontSize: ConstantFontSize.FONT_SIZE_12_0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: ConstantSpace.SPACE_4_5,
                    height: ConstantSpace.SPACE_4_5,
                    child: FlatButton(
                      color: SharedColor.COLOR_YELLOW_400,
                      shape: CircleBorder(),
                      onPressed: () => CommonsWidget().launchMapsUrl(
                        lat: list[index].latitude,
                        lng: list[index].longitude,
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: SharedColor.COLOR_BLACK_100,
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: ConstantSpace.SPACE_4_5,
                    height: ConstantSpace.SPACE_4_5,
                    child: FlatButton(
                      color: SharedColor.COLOR_GREEN_400,
                      shape: CircleBorder(),
                      onPressed: () => CommonsWidget().showModalSheet(
                        context: context,
                        body: _containerInfoBottomSheet(context, list[index]),
                      ),
                      child: Icon(
                        Icons.info,
                        color: SharedColor.COLOR_BLACK_100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ConstantSpace.SPACE_4),
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
      separatorBuilder: (context, index) =>
          SizedBox(height: ConstantSpace.SPACE_3),
      itemCount: count,
    );
  }

  Widget _containerInfoBottomSheet(
      BuildContext context, LocationTestCovidModel model) {
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
              '${model.name}',
              style: GoogleFonts.montserratAlternates(
                  color: SharedColor.COLOR_BLACK_400,
                  fontSize: ConstantFontSize.FONT_SIZE_14_0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5),
            ),
          ),
          SizedBox(height: ConstantSpace.SPACE_4),
          Text(
            AppLocalizations.of(context).translate('genereal_available_test_covid'),            
            style: GoogleFonts.montserratAlternates(
                color: SharedColor.COLOR_BLACK_400,
                fontSize: ConstantFontSize.FONT_SIZE_13_0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5),
          ),
          SizedBox(height: ConstantSpace.SPACE_1),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(flex: 1, child: Wrap(children: item(model).toList())),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: ConstantSpace.SPACE_7_5,
                        height: ConstantSpace.SPACE_7_5,
                        child: FlatButton(
                          color: SharedColor.COLOR_GREEN_400,
                          shape: CircleBorder(),
                          onPressed: () {
                            launch("tel:${model.contact}");
                          },
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
          ),
        ],
      ),
    );
  }

  Iterable<Widget> item(LocationTestCovidModel model) sync* {
    for (var item in model.testFacility) {
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
