part of 'pages.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (App.main.user != null) {
      context.bloc<HistoryCubit>().getHistoryCubit(App.main.user.id);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate('menu_history'),
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
                        separatorBuilder: (context, index) => SizedBox(
                              height:
                                  state.histories[index].status.contains("1")
                                      ? ConstantSpace.SPACE_2_5
                                      : ConstantSpace.SPACE_1,
                            ),
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            horizontal: ConstantSpace.SPACE_3,
                            vertical: ConstantSpace.SPACE_3),
                        itemCount: state.histories.length,
                        itemBuilder: (context, index) {
                          return _CardHistory(
                            historyModel: state.histories[index],
                          );
                        });
                  } else {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context).translate('history_empty'),
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

class _CardHistory extends StatelessWidget {
  final HistoryModel historyModel;

  _CardHistory({
    this.historyModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            borderRadius: historyModel.status.contains("1")
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(ConstantSpace.SPACE_1_5),
                    bottomRight: Radius.circular(ConstantSpace.SPACE_5),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(ConstantSpace.SPACE_1_5),
                    topRight: Radius.circular(ConstantSpace.SPACE_5),
                  ),
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
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Padding(
                  padding: historyModel.status.contains("1")
                      ? const EdgeInsets.only(
                          left: ConstantSpace.SPACE_5,
                          top: ConstantSpace.SPACE_3,
                        )
                      : const EdgeInsets.only(
                          left: ConstantSpace.SPACE_5,
                          bottom: ConstantSpace.SPACE_3,
                        ),
                  child: Text(
                    historyModel.status.contains("1")
                        ? AppLocalizations.of(context)
                            .translate('history_go_out')
                        : AppLocalizations.of(context)
                            .translate('history_back_home'),
                    style: GoogleFonts.kodchasan(
                        color: SharedColor.COLOR_BLACK_400,
                        fontSize: ConstantFontSize.FONT_SIZE_16_0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.45),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: ConstantSpace.SPACE_5,
                  width: ConstantSpace.SPACE_5,
                  child: Image.asset(historyModel.status.contains("1")
                      ? 'assets/icons/out.png'
                      : 'assets/icons/in.png'),
                ),
              ),
              SizedBox(
                width: ConstantSpace.SPACE_3,
              )
            ],
          ),
        ),
        historyModel.status.contains("2")
            ? Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ConstantSpace.SPACE_2,
                    vertical: ConstantSpace.SPACE_1,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(ConstantSpace.SPACE_3),
                    ),
                    color: SharedColor.COLOR_YELLOW_400,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: SharedColor.COLOR_BLACK_200,
                    //     spreadRadius: 0,
                    //     blurRadius: 4,
                    //     offset: Offset(4, -2),
                    //   ),
                    // ],
                  ),
                  child: Text(
                    '${historyModel.time}',
                    style: GoogleFonts.kodchasan(
                        color: SharedColor.COLOR_PRIMARY,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.45),
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            : Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ConstantSpace.SPACE_2,
                    vertical: ConstantSpace.SPACE_1,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(ConstantSpace.SPACE_3),
                    ),
                    color: SharedColor.COLOR_YELLOW_400,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: SharedColor.COLOR_BLACK_200,
                    //     spreadRadius: 0,
                    //     blurRadius: 4,
                    //     offset: Offset(3, 3),
                    //   ),
                    // ],
                  ),
                  child: Text(
                    '${historyModel.time}',
                    style: GoogleFonts.kodchasan(
                        color: SharedColor.COLOR_PRIMARY,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.45),
                    textAlign: TextAlign.left,
                  ),
                ),
              )
      ],
    );
  }
}
