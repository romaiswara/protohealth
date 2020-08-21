part of 'widgets.dart';

class Chart extends StatefulWidget {
  final int dirawat;
  final int sembuh;
  final int meniggal;
  final int positif;

  const Chart({Key key, this.dirawat, this.sembuh, this.meniggal, this.positif})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => ChartState();
}

class ChartState extends State<Chart> {
  int touchedIndex;

  double getPercentage(double val) {
    return val / (widget.positif) * 100;
  }

  @override
  Widget build(BuildContext context) {
    int _dirawat = widget.dirawat;
    int _sembuh = widget.sembuh;
    int _meninggal = widget.meniggal;
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.3,
          child: Row(
            children: <Widget>[
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                        pieTouchData:
                            PieTouchData(touchCallback: (pieTouchResponse) {
                          setState(() {
                            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                pieTouchResponse.touchInput is FlPanEnd) {
                              touchedIndex = -1;
                            } else {
                              touchedIndex =
                                  pieTouchResponse.touchedSectionIndex;
                            }
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 30,
                        sections: showingSections()),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Indicator(
                    color: SharedColor.COLOR_YELLOW_400,
                    text: 'home_inpatient',
                    value: _dirawat,
                  ),
                  SizedBox(height: ConstantSpace.SPACE_0_7_5),
                  Indicator(
                    color: SharedColor.COLOR_GREEN_400,
                    text: 'home_recover',
                    value: _sembuh,
                  ),
                  SizedBox(height: ConstantSpace.SPACE_0_7_5),
                  Indicator(
                    color: SharedColor.COLOR_BLACK_200,
                    text: 'home_died',
                    value: _meninggal,
                  ),                  
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: SharedColor.COLOR_BLACK_200,
            value: widget.meniggal.toDouble(),
            title: '${getPercentage(widget.meniggal.toDouble()).round()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: SharedColor.COLOR_YELLOW_400,
            value: widget.dirawat.toDouble(),
            title: '${getPercentage(widget.dirawat.toDouble()).round()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: SharedColor.COLOR_GREEN_400,
            value: widget.sembuh.toDouble(),
            title: '${getPercentage(widget.sembuh.toDouble()).round()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
