part of 'widgets.dart';

class LoaderUpdateToday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ConstantSpace.SPACE_2_2_5,
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  LoaderText(
                      height: ConstantSpace.SPACE_1_5, widthPercentage: 0.25),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.075,
                  ),
                  LoaderText(
                    height: ConstantSpace.SPACE_1_5,
                    widthPercentage: 0.16,
                  )
                ],
              ),
              SizedBox(height: ConstantSpace.SPACE_1_5),
              Row(
                children: <Widget>[
                  LoaderText(
                    height: ConstantSpace.SPACE_1_5,
                    widthPercentage: 0.25,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.075,
                  ),
                  LoaderText(
                    height: ConstantSpace.SPACE_1_5,
                    widthPercentage: 0.13,
                  )
                ],
              ),
              SizedBox(height: ConstantSpace.SPACE_1_5),
              Row(
                children: <Widget>[
                  LoaderText(
                    height: ConstantSpace.SPACE_1_5,
                    widthPercentage: 0.2,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.125,
                  ),
                  LoaderText(
                    height: ConstantSpace.SPACE_1_5,
                    widthPercentage: 0.13,
                  )
                ],
              ),
              SizedBox(height: ConstantSpace.SPACE_1_5),
              Row(
                children: <Widget>[
                  LoaderText(
                    height: ConstantSpace.SPACE_1_5,
                    widthPercentage: 0.175,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  LoaderText(
                    height: ConstantSpace.SPACE_1_5,
                    widthPercentage: 0.15,
                  )
                ],
              ),
              SizedBox(height: ConstantSpace.SPACE_3),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: ConstantSpace.SPACE_1),
          height: MediaQuery.of(context).size.height * 0.045,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ConstantSpace.SPACE_1_5),
              color: SharedColor.COLOR_BLACK_200),
        )
      ],
    );
  }
}
