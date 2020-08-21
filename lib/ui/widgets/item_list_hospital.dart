part of 'widgets.dart';

class ItemLIstHospital extends StatelessWidget {
  final HospitalModel hospitalModel;
  final Widget bodyBottomshet;

  const ItemLIstHospital({Key key, this.hospitalModel, this.bodyBottomshet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.bloc<GoogleMapCubit>().changeLocation(LatLng(
              hospitalModel.latitude,
              hospitalModel.longitude,
            ),);
      },
      child: Container(
//        height: MediaQuery.of(context).size.height * 0.175,
        padding: EdgeInsets.symmetric(
          horizontal: ConstantSpace.SPACE_3,
          vertical: ConstantSpace.SPACE_3,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: SharedColor.COLOR_YELLOW_500,
                      size: ConstantFontSize.FONT_SIZE_24_0,
                    ),
                    SizedBox(width: ConstantSpace.SPACE_0_5),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.225,
                      child: Text(
                        '${hospitalModel.province}',
                        style: GoogleFonts.montserratAlternates(
                            color: SharedColor.COLOR_BLACK_400,
                            fontSize: ConstantFontSize.FONT_SIZE_12_0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.45),
                            maxLines: 2,
                      ),
                    ),
                  ],
                ),                
                Expanded(
                  child: Container(                    
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${hospitalModel.name}',
                      style: GoogleFonts.montserratAlternates(
                          color: SharedColor.COLOR_BLACK_400,
                          fontSize: ConstantFontSize.FONT_SIZE_14_0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: ConstantSpace.SPACE_1),
                    child: Text(
                      '${hospitalModel.address}',
                      style: GoogleFonts.montserratAlternates(
                          color: SharedColor.COLOR_BLACK_300,
                          fontSize: ConstantFontSize.FONT_SIZE_12_0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                SizedBox(width: ConstantSpace.SPACE_1),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ButtonTheme(
                      minWidth: ConstantSpace.SPACE_4_5,
                      height: ConstantSpace.SPACE_4_5,
                      child: FlatButton(
                        color: SharedColor.COLOR_RED_400,
                        shape: CircleBorder(),
                        onPressed: () => CommonsWidget().showModalSheet(
                          context: context,
                          body: bodyBottomshet,
                        ),
                        child: Icon(
                          Icons.more_vert,
                          color: SharedColor.COLOR_BLACK_100,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
