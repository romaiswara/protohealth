part of '../cubit.dart';

////////////////////////////////////////////////
//// STATE AREA ////////////////////////////////
////////////////////////////////////////////////
abstract class LocalDataState extends Equatable {}

class LocalDataInitialState extends LocalDataState {
  @override
  List<Object> get props => [];
}

class LocalDataLoadingState extends LocalDataState {
  @override
  List<Object> get props => [];
}

class LocalDataLoadedState extends LocalDataState {
  final Session session;
  final User user;

  LocalDataLoadedState({
    this.session,
    this.user,
  });

  @override
  List<Object> get props => [
        session,
      ];
}

class LocalDataFailureState extends LocalDataState {
  final String errorMessage;

  LocalDataFailureState({
    this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

////////////////////////////////////////////////
//// CUBIT AREA ////////////////////////////////
////////////////////////////////////////////////
class LocalDataCubit extends Cubit<LocalDataState> {
  final Logger logger = Logger('Local Data Cubit');

  LocalDataCubit() : super(LocalDataInitialState());

  void checkLocalData({
    SessionRepository sessionRepository,
    UserRepository userRepository,
  }) async {
    emit(LocalDataLoadingState());
    Session session = await sessionRepository.loadLocal();

    User user = await userRepository.loadLocal();

    // check session identifier
    if (session == null) {
      logger.fine('session not found');
      sessionRepository.saveLocal(Session(
        identifier: Uuid().v4(),
      ));
    }
    emit(LocalDataLoadedState(
      session: session,
      user: user,
    ));
  }

  void updateSessionUser({SessionRepository repository, String userId}) async {
    emit(LocalDataLoadingState());
    Session session = await repository.loadLocal();
    repository.saveLocal(session.copyWith(userId: userId));
    emit(LocalDataLoadedState(
      session: session.copyWith(userId: userId),
    ));
  }

  void updateSessionLanguage(
      {SessionRepository repository,
      String languageCode,
      UserRepository userRepository}) async {
    emit(LocalDataLoadingState());
    Session session = await repository.loadLocal();
    repository.saveLocal(session.copyWith(languageCode: languageCode));

    User user = await userRepository.loadLocal();
    emit(LocalDataLoadedState(
      session: session.copyWith(languageCode: languageCode),
      user: user,
    ));
  }

  void saveUser({UserRepository repository, User user}) async {
    await repository.saveLocal(user);
    // SEND TO SERVER
    await UserService.updateUser(user);

    checkLocalData(
      sessionRepository: SessionRepository(),
      userRepository: repository,
    );
  }

  void updateUser({
    SessionRepository sessionRepository,
    UserRepository userRepository,
    String id,
    String email,
    String name,
    double latitude,
    double longitude,
    String reminder,
  }) async {
    Session session = await sessionRepository.loadLocal();
    User user = User(
      id: id,
      email: email,
      identifier: session.identifier,
      name: name,
      addressLatitude: latitude,
      addressLongitude: longitude,
      reminder: reminder,
    );
    // SEND TO SERVER
    await UserService.updateUser(user);
    saveUser(repository: userRepository, user: user);
  }

  void clearUser({UserRepository repository}) async {
    // clear status
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove('status');

    await repository.clearLocal();
    checkLocalData(
      sessionRepository: SessionRepository(),
      userRepository: repository,
    );
  }
}
