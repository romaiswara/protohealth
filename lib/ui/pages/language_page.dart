part of 'pages.dart';

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              AppLocalizations.of(context).translate('account_language'),
              style: GoogleFonts.montserratAlternates(
                  color: SharedColor.COLOR_BLACK_400,
                  fontSize: ConstantFontSize.FONT_SIZE_16_0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.45),
              textAlign: TextAlign.right,
            ),
          ),
          body: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                SizedBox(height: 8),
                _LanguageTile(
                  locale: Locales.en,
                  title: AppLocalizations.of(context)
                      .translate('language_english'),
                ),
                _LanguageTile(
                  locale: Locales.id,
                  title: AppLocalizations.of(context)
                      .translate('language_indonesian'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LanguageTile extends StatelessWidget {
  /// Language of this tile
  final Locale locale;

  /// title
  final String title;

  _LanguageTile({
    this.locale,
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LanguageCubit _languageCubit = context.bloc<LanguageCubit>();
    final bool _isSelected = (locale == _languageCubit.state);
    return GestureDetector(
      onTap: () {
        if (!_isSelected) {
          _languageCubit.change(locale);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: SharedColor.COLOR_BLACK_200,
              width: 1.25,
            ),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.symmetric(
          horizontal: ConstantSpace.SPACE_2,
          vertical: ConstantSpace.SPACE_2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.montserratAlternates(
                    color: SharedColor.COLOR_BLACK_400,
                    fontSize: ConstantFontSize.FONT_SIZE_14_0,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5),
              ),
            ),
            SizedBox(width: ConstantSpace.SPACE_1),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: _isSelected
                      ? SharedColor.COLOR_YELLOW_400
                      : SharedColor.COLOR_BLACK_300,
                  width: 2,
                ),
                shape: BoxShape.circle,
                color: SharedColor.COLOR_BLACK_100,
              ),
              padding: EdgeInsets.all(ConstantSpace.SPACE_0_7_5),
              child: Container(
                width: ConstantSpace.SPACE_1_5,
                height: ConstantSpace.SPACE_1_5,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: _isSelected
                          ? SharedColor.COLOR_YELLOW_400
                          : SharedColor.COLOR_BLACK_100,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                    color: _isSelected
                        ? SharedColor.COLOR_YELLOW_400
                        : SharedColor.COLOR_BLACK_100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
