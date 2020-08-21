part of 'widgets.dart';

class CommonsWidget {
  void showModalSheet({
    BuildContext context,
    Widget body,
  }) {
    Widget modal() {
      double width = MediaQuery.of(context).size.width;
      return Container(
        padding: EdgeInsets.only(
            top: ConstantSpace.SPACE_2,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  bottom: ConstantSpace.SPACE_2_5,
                  top: ConstantSpace.SPACE_0_5),
              width: width * 0.125,
              height: 5.5,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(ConstantSpace.SPACE_0_5)),
            ),
            body,
          ],
        ),
      );
    }

    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ConstantSpace.SPACE_3),
              topRight: Radius.circular(ConstantSpace.SPACE_3)),
        ),
        builder: (_) {
          return modal();
        });
  }

  void snackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: SharedColor.COLOR_YELLOW_500,
      duration: Duration(seconds: 1),
    ));
  }

  void launchMapsUrl({
    double lat,
    double lng,
  }) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}