import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import 'config/configs.dart';
import 'core/core.dart';
import 'cubit/cubit.dart';
import 'repository/repository.dart';
import 'shared/shared.dart';
import 'ui/pages/pages.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
      '${record.level.name}: ${record.loggerName}: ${record.time}: ${record.message}',
    );
  });

  GetIt.instance.registerSingleton(
    App(),
  );

  // ensure initialized
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Logger logger = Logger('Main MyApp');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// FOR DATA LOCAL
        BlocProvider<LocalDataCubit>(
          create: (_) => LocalDataCubit(),
        ),

        /// FOR LANGUAGE
        BlocProvider<LanguageCubit>(
          create: (_) => LanguageCubit(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<LocalDataCubit, LocalDataState>(
            listener: (context, state) {
              logger.fine('LocalDataCubit ${state.toString()}');
              if (state is LocalDataLoadedState) {
                // save value to global variable
                App.main.session = state.session;
                App.main.user = state.user;

                if (state.session.langguageCode != null) {
                  Locale locale =
                      (state.session.langguageCode == Locales.en.languageCode)
                          ? Locales.en
                          : Locales.id;
                  context.bloc<LanguageCubit>().change(locale);
                }
              }
            },
          ),
          BlocListener<LanguageCubit, Locale>(
            listener: (context, state) async {
              logger.fine('LanguangeCubit ${state.toString()}');
              await context.bloc<LocalDataCubit>().updateSessionLanguage(
                    repository: SessionRepository(),
                    languageCode: state.languageCode,
                    userRepository: UserRepository(),
                  );
            },
          ),
        ],
        child: BlocBuilder<LanguageCubit, Locale>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Hackfest 2020',
              theme: _myTheme(),
              locale: state,
              supportedLocales: Locales.supported,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              home: SplashPage(),
            );
          },
        ),
      ),
    );
  }
}

ThemeData _myTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      scaffoldBackgroundColor: SharedColor.COLOR_BLACK_100,
      appBarTheme: AppBarTheme(
          color: SharedColor.COLOR_BLACK_100,
          iconTheme: IconThemeData(
            color: SharedColor.COLOR_BLACK_400,
          )));
}
