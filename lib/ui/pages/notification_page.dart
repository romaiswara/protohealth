part of 'pages.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (App.main.user != null) {
      context.bloc<HistoryCubit>().getHistoryCubit(App.main.user.id);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate('menu_notification'),
          style: GoogleFonts.montserratAlternates(
              color: SharedColor.COLOR_BLACK_400,
              fontSize: ConstantFontSize.FONT_SIZE_16_0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.45),
          textAlign: TextAlign.right,
        ),
      ),
      body: (App.main.user == null)
          ? LoginWidget()
          : BlocBuilder<HistoryCubit, HistoryState>(
              builder: (context, state) {
                if (state is HistoryLoadedState) {
                  if (state.histories.length > 0) {
                    return ListView.separated(
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: ConstantSpace.SPACE_0_7_5),
                        itemCount: state.histories.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: <Widget>[
                                _CardNotification(
                                  historyModel: state.histories[index],
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context).translate('notification_empty'),
                        style: GoogleFonts.kodchasan(
                            color: SharedColor.COLOR_BLACK_400,
                            fontSize: ConstantFontSize.FONT_SIZE_14_0,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.45),
                        textAlign: TextAlign.left,
                      ),
                    );
                  }
                }
                return SizedBox();
              },
            ),
    );
  }
}

class _CardNotification extends StatelessWidget {
  final HistoryModel historyModel;

  _CardNotification({
    this.historyModel,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: ConstantSpace.SPACE_2_5,
        vertical: ConstantSpace.SPACE_2,
      ),
      decoration: BoxDecoration(
        color: SharedColor.COLOR_BLACK_50,
        // boxShadow: [
        //   BoxShadow(
        //     color: SharedColor.COLOR_BLACK_200,
        //     spreadRadius: 0,
        //     blurRadius: 7,
        //     offset: Offset(2, 8),
        //   ),
        // ],
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Text(
              '${historyModel.time}',
              style: GoogleFonts.montserratAlternates(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5),
              textAlign: TextAlign.right,
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                height: ConstantSpace.SPACE_3_5,
                width: ConstantSpace.SPACE_3_5,
                child: Image.asset(historyModel.status.contains("1")
                    ? 'assets/icons/out.png'
                    : 'assets/icons/in.png'),
              ),
              SizedBox(width: ConstantSpace.SPACE_2_5),
              Container(
                width: width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      historyModel.status.contains("1")
                          ? AppLocalizations.of(context).translate('notification_out')
                          : AppLocalizations.of(context).translate('notification_in'),
                      style: GoogleFonts.montserratAlternates(
                          color: SharedColor.COLOR_BLACK_400,
                          fontSize: ConstantFontSize.FONT_SIZE_14_0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5),
                    ),
                    Text(
                      historyModel.status.contains("1")
                          ? AppLocalizations.of(context).translate('notif_content_out')
                          : AppLocalizations.of(context).translate('notif_content_in'),
                      style: GoogleFonts.montserratAlternates(
                          color: SharedColor.COLOR_BLACK_300,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
