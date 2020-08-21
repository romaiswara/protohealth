part of '../cubit.dart';

////////////////////////////////////////////////
//// STATE AREA ////////////////////////////////
////////////////////////////////////////////////
abstract class UserState extends Equatable {}

class UserInitialState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UserState {
  final User user;

  UserLoadedState({
    this.user,
  });

  @override
  List<Object> get props => [
        user,
      ];
}

class UserFailureState extends UserState {
  final String errorMessage;

  UserFailureState({
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
class UserCubit extends Cubit<UserState> {
  final Logger logger = Logger('User Cubit');

  UserCubit() : super(UserInitialState());

  void getUser({
    String id,
  }) async {
    emit(UserLoadingState());

    try {
      User user = await UserService.getUser(id);
      emit(UserLoadedState(user: user));
    } catch (e) {
      emit(UserFailureState(errorMessage: e.toString()));
    }
  }
}
