part of 'widgets.dart';

class LoaderCovidUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: ConstantSpace.SPACE_0_5),
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
            SizedBox(width: ConstantSpace.SPACE_1),
            LoaderText(
              height: ConstantSpace.SPACE_1_5,
              widthPercentage: 0.2,
            ),
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
            _itemWrapLoader(),
            _itemWrapLoader(),
            _itemWrapLoader(),
            _itemWrapLoader(),
          ],
        ),
      ],
    );
  }

  Widget _itemWrapLoader() {
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
                LoaderText(
                  height: ConstantSpace.SPACE_2,
                  widthPercentage: 0.185,
                ),
                SizedBox(height: ConstantSpace.SPACE_1),
                LoaderText(
                  height: ConstantSpace.SPACE_1_5,
                  widthPercentage: 0.125,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: LoaderText(
              height: ConstantSpace.SPACE_1_5,
              widthPercentage: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}
