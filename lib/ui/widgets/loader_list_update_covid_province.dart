part of 'widgets.dart';

class LoaderListUpdateCovidProvince extends StatelessWidget {
  final int length;

  LoaderListUpdateCovidProvince({this.length});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: ConstantSpace.SPACE_2_5,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: length,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  LoaderText(
                    height: ConstantSpace.SPACE_2,
                    widthPercentage: 0.325,
                  ),
                  SizedBox(width: ConstantSpace.SPACE_2),
                  LoaderText(
                    height: ConstantSpace.SPACE_1 + ConstantSpace.SPACE_0_7_5,
                    widthPercentage: 0.225,
                  ),
                ],
              ),
              SizedBox(height: ConstantSpace.SPACE_2),
              Padding(
                padding: const EdgeInsets.only(left: ConstantSpace.SPACE_1),
                child: Wrap(
                  children: <Widget>[
                    _itemWrap(width * 0.17),
                    _itemWrap(width * 0.18),
                    _itemWrap(width * 0.17),
                    _itemWrap(width * 0.19),
                  ],
                ),
              )             
            ],
          ),
        );
      },
    );
  }

  Widget _itemWrap(double width) {
    return Container(
      width: width,
      height: ConstantSpace.SPACE_5,
      margin: EdgeInsets.only(
          right: ConstantSpace.SPACE_2, bottom: ConstantSpace.SPACE_2),
      padding: EdgeInsets.symmetric(
          horizontal: ConstantSpace.SPACE_1_5, vertical: ConstantSpace.SPACE_1),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: SharedColor.COLOR_BLACK_200),
        color: SharedColor.COLOR_BLACK_200,
        borderRadius: BorderRadius.circular(ConstantSpace.SPACE_2),
      ),
    );
  }
}
