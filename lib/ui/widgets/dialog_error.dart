part of 'widgets.dart';

void showDialogError({
  BuildContext context,
  String message,
}) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(
          AppLocalizations.of(context).translate('general_error'),
          style: TextStyle(fontSize: 22),
        ),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('general_ok')),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
