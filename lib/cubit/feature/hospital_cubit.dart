part of '../cubit.dart';

////////////////////////////////////////////////
//// STATE AREA ////////////////////////////////
////////////////////////////////////////////////
abstract class HospitalState extends Equatable {}

class HospitalLoadingState extends HospitalState {
  @override
  List<Object> get props => [];
}

class HospitalLoadedState extends HospitalState {
  final List<HospitalModel> list;

  HospitalLoadedState({this.list});

  @override
  List<Object> get props => [
        list,
      ];
}

class HospitalFailureState extends HospitalState {
  final String errorMessage;

  HospitalFailureState({
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
class HospitalCubit extends Cubit<HospitalState> {
  StreamSubscription _hospitalSubscription;

  HospitalCubit() : super(HospitalLoadingState());

  void getHospital() async {
//    List<HospitalModel> _list = await HospitalService.getHospital();
//    emit(HospitalLoadedState(list: _list));
    _hospitalSubscription?.cancel();
    _hospitalSubscription =
        HospitalService.getHospitalStream().listen((hospitals) async {
      emit(HospitalLoadingState());
      await Future.delayed(Duration(milliseconds: 500));
      emit(HospitalLoadedState(list: hospitals));
    }, onError: (e) {
      emit(HospitalFailureState(errorMessage: e.toString()));
    });
  }

  @override
  Future<void> close() async {
    await _hospitalSubscription?.cancel();
    return super.close();
  }
}
