part of 'widgets.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;      
  final int value;

  const Indicator({
    Key key,
    this.color,
    this.text,            
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: ConstantSpace.SPACE_1_5,
          height: ConstantSpace.SPACE_1_5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate(text),
              style: GoogleFonts.montserratAlternates(
                  color: SharedColor.COLOR_BLACK_400,
                  fontSize: ConstantFontSize.FONT_SIZE_11_0,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.6),
            ),
            Text(
              '${Utility().formatNumber(value)}',
              style: GoogleFonts.montserratAlternates(
                  color: SharedColor.COLOR_BLACK_400,
                  fontSize: ConstantFontSize.FONT_SIZE_12_0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6),
            ),
          ],
        )
      ],
    );
  }
}
