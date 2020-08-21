part of 'widgets.dart';

class CardGeneral extends StatelessWidget {
  final Widget header;
  final Widget body;
  final Widget footer;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry margin;

  CardGeneral({
    this.header,
    @required this.body,
    this.footer,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: margin,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: <Widget>[
          if (header != null) ...[
            header,
            Divider(
              thickness: 2,
              height: 30,
            ),
          ],
          body,
          if (footer != null) ...[
            Column(
              children: <Widget>[
                Divider(
                  thickness: 2,
                  height: 30,
                ),
                footer,
              ],
            ),
          ],
        ],
      ),
    );
  }
}
