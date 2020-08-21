part of 'pages.dart';

class LoginPage extends StatelessWidget {
  final AuthCubit authCubit = AuthCubit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => authCubit,
        ),

        /// FOR CONNECTION
        BlocProvider<ConnectionCubit>(
          create: (_) => ConnectionCubit(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) async {
              if (state is AuthLoadedState) {
                await context.bloc<LocalDataCubit>().saveUser(
                      repository: UserRepository(),
                      user: state.user,
                    );

                if (state.user.identifier == null) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => UpdateProfilePage(
                              user: state.user,
                            )),
                    (route) => false,
                  );
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                    (route) => false,
                  );
                }
              }
              if (state is AuthFailureState) {
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
          body: Center(
            child: RaisedButton(
              onPressed: () {
                authCubit.signIn();
              },
              child: Text(
                AppLocalizations.of(context).translate('account_login'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
