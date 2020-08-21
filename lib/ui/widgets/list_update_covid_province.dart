part of 'widgets.dart';

class ListUpdateCovidProvince extends StatelessWidget {
  final List<CovidProvinsiModel> list;
  final bool isCutLength;

  const ListUpdateCovidProvince({Key key, this.list, this.isCutLength}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count;
    if (isCutLength) {
      count = (list.length > 3) ? 3 : list.length;
    } else {
      count = list.length;
    }
    // final width = MediaQuery.of(context).size.width;
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: ConstantSpace.SPACE_2_5,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: count,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConstantSpace.SPACE_3),
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
          padding: EdgeInsets.only(
            left: ConstantSpace.SPACE_2,
            right: ConstantSpace.SPACE_2,
            top: ConstantSpace.SPACE_2,
            bottom: ConstantSpace.SPACE_1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(       
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(                    
                    child: Text(
                      list[index].provinsi,
                      style: GoogleFonts.montserratAlternates(
                          color: SharedColor.COLOR_BLACK_300,
                          fontSize: ConstantFontSize.FONT_SIZE_14_0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5),
                    ),
                  ),
                  SizedBox(width: ConstantSpace.SPACE_2),
                  Text(
                    list[index].lastDate,
                    style: GoogleFonts.montserratAlternates(
                        color: SharedColor.COLOR_BLACK_400,
                        fontSize: ConstantFontSize.FONT_SIZE_12_0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.5),
                  ),
                ],
              ),
              SizedBox(height: ConstantSpace.SPACE_2),
              Padding(
                padding: const EdgeInsets.only(left: ConstantSpace.SPACE_1),
                child: Wrap(
                  children: <Widget>[
                    _itemWrap(
                      AppLocalizations.of(context).translate('home_positive'),
                      list[index].jumlahKasus,
                      SharedColor.COLOR_RED_500,
                    ),
                    _itemWrap(
                      AppLocalizations.of(context).translate('home_recover'),
                      list[index].jumlahSembuh,
                      SharedColor.COLOR_GREEN_500,
                    ),
                    _itemWrap(
                      AppLocalizations.of(context).translate('home_inpatient'),
                      list[index].jumlahDirawat,
                      SharedColor.COLOR_YELLOW_500,
                    ),
                    _itemWrap(
                      AppLocalizations.of(context).translate('home_died'),
                      list[index].jumlahMeninggal,
                      SharedColor.COLOR_BLACK_300,
                    ),
                  ],
                ),
              )
              // _itemWrap(
              //   'Positif',
              //   list[index].jumlahKasus,
              //   SharedColor.COLOR_RED_500,
              // ),
              // Text('Jumlah Kasus ${list[index].jumlahKasus}'),
              // Text('Jumlah Sembuh ${list[index].jumlahSembuh}'),
              // Text('Jumlah Meninggal ${list[index].jumlahMeninggal}'),
              // Text('Jumlah Dirawat ${list[index].jumlahDirawat}'),
            ],
          ),
        );
      },
    );
  }

  Widget _itemWrap(String text, data1, Color color) {
    return Container(
      margin: EdgeInsets.only(
          right: ConstantSpace.SPACE_2, bottom: ConstantSpace.SPACE_2),
      padding: EdgeInsets.symmetric(
          horizontal: ConstantSpace.SPACE_1_5, vertical: ConstantSpace.SPACE_1),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: SharedColor.COLOR_BLACK_200),
        color: SharedColor.COLOR_BLACK_50,
        borderRadius: BorderRadius.circular(ConstantSpace.SPACE_2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Utility().formatNumber(data1),
            style: GoogleFonts.montserratAlternates(
                color: color,
                fontSize: ConstantFontSize.FONT_SIZE_14_0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5),
          ),
          Text(
            text,
            style: GoogleFonts.montserratAlternates(
                color: SharedColor.COLOR_BLACK_300,
                fontSize: ConstantFontSize.FONT_SIZE_11_0,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }
}
