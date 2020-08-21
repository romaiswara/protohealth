part of 'pages.dart';

class UpdateCovidProvincePage extends StatelessWidget {
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
              AppLocalizations.of(context).translate('update_covid_province_header'),
              style: GoogleFonts.montserratAlternates(
                  color: SharedColor.COLOR_BLACK_400,
                  fontSize: ConstantFontSize.FONT_SIZE_16_0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.45),
              textAlign: TextAlign.right,
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: ConstantSpace.SPACE_3,
                vertical: ConstantSpace.SPACE_3),
            physics: BouncingScrollPhysics(),
            child: BlocBuilder<CovidCubit, CovidState>(
              builder: (context, state) {
                if (state is CovidLoadingState) {
                  return LoaderListUpdateCovidProvince(
                    length: 4,
                  );
                }
                if (state is CovidLoadedState) {
                  return ListUpdateCovidProvince(
                    list: state.covidsProvinsi,
                    isCutLength: false,
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
