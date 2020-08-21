part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (_) => SplashCubit()
        ..getData(
          sessionRepository: SessionRepository(),
          userRepository: UserRepository(),
        ),
      child: BlocListener<SplashCubit, SplashState>(
        listener: _afterSplashListener,
        child: Scaffold(
          backgroundColor: SharedColor.COLOR_BLACK_100,
          body: Center(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
              width: 150,
            ),
          ),
        ),
      ),
    );
  }

  void _afterSplashListener(BuildContext context, SplashState state) async {
    if (state is SplashLoadedState) {
      await Future.delayed(Duration(seconds: 2));
      // UPDATE ON LOCAL DATA
      context.bloc<LocalDataCubit>().checkLocalData(
            sessionRepository: SessionRepository(),
            userRepository: UserRepository(),
          );

      if (state.session == null) {
        // GO TO ONBOARDING PAGE
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => OnBoardingPage()),
          (route) => false,
        );
      } else if (state.user != null) {
        if (state.user.identifier == null) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => UpdateProfilePage(
                user: state.user,
              ),
            ),
            (route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => DashboardPage(),
            ),
            (route) => false,
          );
        }
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
          (route) => false,
        );
      }
    }
  }
}
