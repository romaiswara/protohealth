part of '../cubit.dart';

////////////////////////////////////////////////
//// STATE AREA ////////////////////////////////
////////////////////////////////////////////////
abstract class SplashState extends Equatable {}

class SplashInitialState extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashLoadedState extends SplashState {
  final Session session;
  final User user;

  SplashLoadedState({
    this.session,
    this.user,
  });

  @override
  List<Object> get props => [
        user,
      ];
}

////////////////////////////////////////////////
//// CUBIT AREA ////////////////////////////////
////////////////////////////////////////////////
class SplashCubit extends Cubit<SplashState> {
  final Logger logger = Logger('Splash Cubit');

  SplashCubit() : super(SplashInitialState());

  void getData({
    SessionRepository sessionRepository,
    UserRepository userRepository,
  }) async {
    Session session = await sessionRepository.loadLocal();
    User user = await userRepository.loadLocal();

    // check session identifier
    if (session == null) {
      logger.fine('session not found');
      sessionRepository.saveLocal(Session(
        identifier: Uuid().v4(),
      ));
    } else {
      logger.fine('session available');
    }

    emit(SplashLoadedState(
      session: session,
      user: user,
    ));
  }
}
