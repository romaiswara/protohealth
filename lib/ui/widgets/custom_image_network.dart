part of 'widgets.dart';

class CustomImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double borderRadiusVal;

  const CustomImageNetwork({Key key, this.imageUrl, this.borderRadiusVal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadiusVal)),
      child: CachedNetworkImage(
        placeholder: (context, url) => Container(
          color: SharedColor.COLOR_BLACK_200.withOpacity(0.9),
          child: Center(
            child: Icon(Icons.image, color: SharedColor.COLOR_BLACK_100),
          ),
        ),
        imageUrl: imageUrl??'IMAGE_URL_NULL',
        fit: BoxFit.cover,
      ),
    );
  }
}
