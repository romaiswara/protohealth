part of '../cubit.dart';

////////////////////////////////////////////////
//// STATE AREA ////////////////////////////////
////////////////////////////////////////////////
abstract class CovidState extends Equatable {}

class CovidInitialState extends CovidState {
  @override
  List<Object> get props => [];
}

class CovidLoadingState extends CovidState {
  @override
  List<Object> get props => [];
}

class CovidLoadedState extends CovidState {
  final CovidDataModel covidDataModel;
  final CovidUpdateModel covidUpdateTambah;
  final CovidUpdateModel covidUpdateTotal;
  final List<CovidProvinsiModel> covidsProvinsi;

  CovidLoadedState({
    this.covidDataModel,
    this.covidUpdateTambah,
    this.covidUpdateTotal,
    this.covidsProvinsi,
  });

  @override
  List<Object> get props => [
        covidDataModel,
        covidUpdateTambah,
        covidUpdateTotal,
        covidsProvinsi,
      ];
}

class CovidFailureState extends CovidState {
  final String errorMessage;

  CovidFailureState({
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
class CovidCubit extends Cubit<CovidState> {
  CovidCubit() : super(CovidInitialState());

  void getAllData() async {
    emit(CovidLoadingState());

    try {
      /// Update covid
      Response responseUpdate = await Dio(
        BaseOptions(
          connectTimeout: 10000,
          receiveTimeout: 10000,
        ),
      ).get(
        ConstantString.URL_UPDATE_COVID,
      );

      CovidDataModel covidDataModel = CovidDataModel.fromJson(
        responseUpdate.data['data'],
      );

      CovidUpdateModel covidUpdateTambah = CovidUpdateModel.fromJson(
        (responseUpdate.data['update'])['penambahan'],
      );

      CovidUpdateModel covidUpdateTotal = CovidUpdateModel.fromJson(
        (responseUpdate.data['update'])['total'],
      );

      /// Provinsi covid
      List<CovidProvinsiModel> covids = [];
      Response responseProvinsi = await Dio(
        BaseOptions(
          connectTimeout: 10000,
          receiveTimeout: 10000,
        ),
      ).get(ConstantString.URL_PROV_COVID);
      List<dynamic> list = responseProvinsi.data['list_data'];
      await list.map(
        (res) {
          covids.add(CovidProvinsiModel.fromJson(
            res,
            responseProvinsi.data['last_date'],
          ));
        },
      ).toList();

      emit(CovidLoadedState(
          covidDataModel: covidDataModel,
          covidUpdateTambah: covidUpdateTambah,
          covidUpdateTotal: covidUpdateTotal,
          covidsProvinsi: covids));
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT ||
          e.type == DioErrorType.DEFAULT) {
        emit(CovidFailureState(errorMessage: 'Sinyal Ang Buruak!'));
      }
    } catch (e) {
//      emit(CovidFailureState(
//        errorMessage: e.toString(),
//      ));
    }
  }
}