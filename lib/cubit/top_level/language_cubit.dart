part of '../cubit.dart';

////////////////////////////////////////////////
//// CUBIT AREA ////////////////////////////////
////////////////////////////////////////////////
class LanguageCubit extends Cubit<Locale> {
  final Logger logger = Logger('Language Cubit');

  LanguageCubit({SessionRepository repository}) : super(_defaultLocale);

  void change(Locale locale) async {
    logger.fine('Locale changed: ' + locale.toString());
    emit(locale);
  }

  static Locale get _defaultLocale {
    if (Locales.supported.contains(window.locale)) {
      return window.locale;
    }

    return Locales.en;
  }
}
