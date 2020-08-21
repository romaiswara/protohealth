part of 'widgets.dart';

class LoaderListNearbyHopitals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(      
      separatorBuilder: (context, index) => SizedBox(height: ConstantSpace.SPACE_3),
      padding: EdgeInsets.symmetric(
        horizontal: ConstantSpace.SPACE_3,
        vertical: ConstantSpace.SPACE_3,
      ),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) => Container(
//        height: MediaQuery.of(context).size.height * 0.175,
        padding: EdgeInsets.symmetric(
          horizontal: ConstantSpace.SPACE_3,
          vertical: ConstantSpace.SPACE_3,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                LoaderText(height: ConstantSpace.SPACE_1_5, widthPercentage: 0.2,),               
                Expanded(
                  child: Container(                    
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        LoaderText(height: ConstantSpace.SPACE_2, widthPercentage: 0.375,),
                        SizedBox(height: ConstantSpace.SPACE_0_5,),
                        LoaderText(height: ConstantSpace.SPACE_2, widthPercentage: 0.175,),
                      ],
                    )
                  ),
                ),
              ],
            ),            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      LoaderText(height: ConstantSpace.SPACE_1_5, widthPercentage: 0.6,),
                      SizedBox(height: ConstantSpace.SPACE_0_5,),
                      LoaderText(height: ConstantSpace.SPACE_1_5, widthPercentage: 0.25,),
                    ],
                  ),
                ),
                SizedBox(width: ConstantSpace.SPACE_1),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: ConstantSpace.SPACE_4_5,
                      width: ConstantSpace.SPACE_4_5,
                      decoration: BoxDecoration(
                        color: SharedColor.COLOR_BLACK_300,
                        shape: BoxShape.circle
                      ),
                    )
                    // ButtonTheme(
                    //   minWidth: ConstantSpace.SPACE_4_5,
                    //   height: ConstantSpace.SPACE_4_5,
                    //   child: FlatButton(
                    //     color: SharedColor.COLOR_RED_400,
                    //     shape: CircleBorder(),
                    //     onPressed: () => CommonsWidget().showModalSheet(
                    //       context: context,
                    //       body: bodyBottomshet,
                    //     ),
                    //     child: Icon(
                    //       Icons.more_vert,
                    //       color: SharedColor.COLOR_BLACK_100,
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
