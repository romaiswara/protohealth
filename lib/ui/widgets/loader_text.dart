part of 'widgets.dart';

class LoaderText extends StatelessWidget {
  final double height;
  final double widthPercentage;

  const LoaderText({Key key, this.height, this.widthPercentage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width * widthPercentage,      
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: SharedColor.COLOR_BLACK_200),
    );
  }
}
