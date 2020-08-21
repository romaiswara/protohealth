part of '../cubit.dart';

////////////////////////////////////////////////
//// STATE AREA ////////////////////////////////
////////////////////////////////////////////////
abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthWaitingDataState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoadedState extends AuthState {
  final User user;

  AuthLoadedState({
    this.user,
  });

  @override
  List<Object> get props => [
        user,
      ];
}

class AuthFailureState extends AuthState {
  final String errorMessage;

  AuthFailureState({
    this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class AuthCancelState extends AuthState {
  @override
  List<Object> get props => [];
}

////////////////////////////////////////////////
//// CUBIT AREA ////////////////////////////////
////////////////////////////////////////////////
class AuthCubit extends Cubit<AuthState> {
  final Logger logger = Logger('Auth Cubit');

  AuthCubit() : super(AuthInitialState());

  void signIn() async {
    try {
      emit(AuthLoadingState());

      SignInSignUpResult result = await AuthServices.signInWithGoogle();

      emit(AuthWaitingDataState());

      if (result.user != null) {
        User user = await UserService.getUser(result.user.id);

        emit(AuthLoadedState(user: user ?? result.user));
      } else {
        emit(AuthFailureState(errorMessage: result.message));
      }
    } on NoSuchMethodError {
      emit(AuthCancelState());
    } catch (e) {
      emit(AuthFailureState(errorMessage: e.toString()));
    }
  }

  void signOut() async {
    emit(AuthLoadingState());
    try {
      await AuthServices.signOut();
      emit(AuthLoadedState(user: null));
    } catch (e) {
      emit(AuthFailureState(errorMessage: e.toString()));
    }
  }
}
