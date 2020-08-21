part of 'pages.dart';

class UpdateCovidPage extends StatefulWidget {
  @override
  _UpdateCovidPageState createState() => _UpdateCovidPageState();
}

class _UpdateCovidPageState extends State<UpdateCovidPage>
    with TickerProviderStateMixin {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CovidCubit>(
          create: (context) => CovidCubit()..getAllData(),
        ),
        /// FOR CONNECTION
        BlocProvider<ConnectionCubit>(
          create: (_) => ConnectionCubit(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CovidCubit, CovidState>(
            listener: (context, state) {
              if (state is CovidFailureState) {
                showDialogError(
                  context: context,
                  message: state.errorMessage,
                );
              }
            },
          ),
          BlocListener<ConnectionCubit, ConnectionInternetState>(
            listener: (context, state) {
              if (state is NoConnectionState) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NoInternetPage()),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              AppLocalizations.of(context).translate('update_covid_title'),
              style: GoogleFonts.montserratAlternates(
                  color: SharedColor.COLOR_BLACK_400,
                  fontSize: ConstantFontSize.FONT_SIZE_16_0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.45),
              textAlign: TextAlign.right,
            ),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: ConstantSpace.SPACE_3,
                vertical: ConstantSpace.SPACE_3),
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: ConstantSpace.SPACE_1),
                child: Text(
                  AppLocalizations.of(context).translate('update_covid_indonesia_today'),
                  style: GoogleFonts.montserratAlternates(
                      color: SharedColor.COLOR_BLACK_500,
                      fontSize: ConstantFontSize.FONT_SIZE_14_0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.6),
                ),
              ),
              SizedBox(height: ConstantSpace.SPACE_2_5),
              BlocBuilder<CovidCubit, CovidState>(
                builder: (context, state) {
                  if (state is CovidLoadingState) {
                    return LoaderUpdateToday();
                  }
                  if (state is CovidLoadedState) {
                    return _udpate(
                      state.covidDataModel,
                      state.covidUpdateTotal,
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(height: ConstantSpace.SPACE_3),
              _headerContentWidget(
                context,
                AppLocalizations.of(context).translate('update_covid_province_header'),
                UpdateCovidProvincePage(),
              ),
              SizedBox(height: ConstantSpace.SPACE_2_5),
              //widget update province
              BlocBuilder<CovidCubit, CovidState>(
                builder: (context, state) {
                  if (state is CovidLoadingState) {
                    return LoaderListUpdateCovidProvince(
                      length: 3,
                    );
                  }
                  if (state is CovidLoadedState) {
                    return Column(
                      children: <Widget>[
                        ListUpdateCovidProvince(
                          list: state.covidsProvinsi,
                          isCutLength: true,
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerContentWidget(
      BuildContext context, String header, Widget nextRoute) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ConstantSpace.SPACE_1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              header,
              style: GoogleFonts.montserratAlternates(
                  color: SharedColor.COLOR_BLACK_500,
                  fontSize: ConstantFontSize.FONT_SIZE_14_0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.6),
            ),
          ),
          SizedBox(width: ConstantSpace.SPACE_2_5),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => nextRoute,
              ),
            ),
            child: Container(
              child: Text(
                AppLocalizations.of(context).translate('general_more'),
                style: GoogleFonts.montserratAlternates(
                    color: SharedColor.COLOR_BLACK_300,
                    fontSize: ConstantFontSize.FONT_SIZE_12_0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.6),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _udpate(
      CovidDataModel covidDataModel, CovidUpdateModel covidUpdateModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _contentRow(
          AppLocalizations.of(context).translate('update_covid_tested_specimen'),
          covidDataModel.totalSpesimen,
        ),
        SizedBox(height: ConstantSpace.SPACE_1),
        _contentRow(
          AppLocalizations.of(context).translate('update_covid_negative'),
          covidDataModel.totalSpesimenNegatif,
        ),
        SizedBox(height: ConstantSpace.SPACE_1),
        _contentRow(
          AppLocalizations.of(context).translate('update_covid_suspect'),
          covidDataModel.jumlahOdp,
        ),
        SizedBox(height: ConstantSpace.SPACE_1),
        _contentRow(
          AppLocalizations.of(context).translate('update_covid_positive'),
          covidUpdateModel.jumlahPositif,
          color: SharedColor.COLOR_RED_500
        ),
        SizedBox(height: ConstantSpace.SPACE_2_5),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: ConstantSpace.SPACE_1,
          ),
          padding: EdgeInsets.only(
            top: ConstantSpace.SPACE_1_5,
            bottom: ConstantSpace.SPACE_1_5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConstantSpace.SPACE_1_5),
            color: SharedColor.COLOR_BLACK_50,
            boxShadow: [
              BoxShadow(
                color: SharedColor.COLOR_BLACK_200,
                spreadRadius: 0,
                blurRadius: 7,
                offset: Offset(2, 5),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: (_show)
                    ? () {
                        setState(() {
                          _show = false;
                        });
                      }
                    : () {
                        setState(() {
                          _show = true;
                        });
                      },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: ConstantSpace.SPACE_2),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context).translate('update_covid_positive'),
                          style: GoogleFonts.montserratAlternates(
                              color: SharedColor.COLOR_BLACK_400,
                              fontSize: ConstantFontSize.FONT_SIZE_13_0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.6),
                        ),
                      ),
                      Icon(
                        _show ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: SharedColor.COLOR_BLACK_400,
                      )
                    ],
                  ),
                ),
              ),
              AnimatedSizeAndFade.showHide(
                fadeDuration: Duration(milliseconds: 500),
                sizeDuration: Duration(milliseconds: 500),
                show: _show,
                vsync: this,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: ConstantSpace.SPACE_1_5,
                      bottom: ConstantSpace.SPACE_0_5),
                  child: Chart(
                    positif: covidUpdateModel.jumlahPositif,
                    dirawat: covidUpdateModel.jumlahDirawat,
                    sembuh: covidUpdateModel.jumlahSembuh,
                    meniggal: covidUpdateModel.jumlahMeninggal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _contentRow(String text, int data, {Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ConstantSpace.SPACE_2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              text,
              style: GoogleFonts.montserratAlternates(
                  color: SharedColor.COLOR_BLACK_400,
                  fontSize: ConstantFontSize.FONT_SIZE_12_0,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.6),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              '${Utility().formatNumber(data)}',
              style: GoogleFonts.montserratAlternates(
                  color: color == null ? SharedColor.COLOR_BLACK_400 : color,
                  fontSize: ConstantFontSize.FONT_SIZE_12_0,
                  fontWeight: color == null ? FontWeight.w400 : FontWeight.w600,
                  letterSpacing: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
