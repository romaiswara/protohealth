part of 'widgets.dart';

class LoaderListNearbyPharmacy extends StatelessWidget {
  final int listCount;

  const LoaderListNearbyPharmacy({Key key, this.listCount}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: listCount,
      separatorBuilder: (context, index) =>
          SizedBox(height: ConstantSpace.SPACE_3),
      itemBuilder: (context, index) => Container(
        width: width,
        padding: EdgeInsets.only(
          top: ConstantSpace.SPACE_2,
          bottom: ConstantSpace.SPACE_1_5,
          left: ConstantSpace.SPACE_3_5,
          right: ConstantSpace.SPACE_3,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                LoaderText(
                  height: ConstantSpace.SPACE_1 + ConstantSpace.SPACE_0_7_5,
                  widthPercentage: 0.2,
                ),
                SizedBox(height: ConstantSpace.SPACE_0_7_5),
                LoaderText(
                  height: ConstantSpace.SPACE_1_5,
                  widthPercentage: 0.3,
                ),
                SizedBox(height: ConstantSpace.SPACE_0_7_5),
                LoaderText(
                  height: ConstantSpace.SPACE_1_5,
                  widthPercentage: 0.1,
                ),
              ],
            ),
            SizedBox(width: ConstantSpace.SPACE_4),
            Container(
              height: ConstantSpace.SPACE_4_5,
              width: ConstantSpace.SPACE_4_5,
              decoration: BoxDecoration(
                  color: SharedColor.COLOR_BLACK_200, shape: BoxShape.circle),
            ),
          ],
        ),
      ),
    );
  }
}
