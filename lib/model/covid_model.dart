part of 'model.dart';

class CovidDataModel extends Equatable {
  final int jumlahOdp;
  final int jumlahPdp;
  final int totalSpesimen;
  final int totalSpesimenNegatif;

  CovidDataModel({
    this.jumlahOdp,
    this.jumlahPdp,
    this.totalSpesimen,
    this.totalSpesimenNegatif,
  });

  factory CovidDataModel.fromJson(Map<String, dynamic> json) {
    return CovidDataModel(
      jumlahOdp: json['jumlah_odp'],
      jumlahPdp: json['jumlah_pdp'],
      totalSpesimen: json['total_spesimen'],
      totalSpesimenNegatif: json['total_spesimen_negatif'],
    );
  }

  @override
  List<Object> get props => [
        jumlahOdp,
        jumlahPdp,
        totalSpesimen,
        totalSpesimenNegatif,
      ];

  @override
  String toString() {
    return 'CovidDataModel{jumlahOdp: $jumlahOdp, jumlahPdp: $jumlahPdp, totalSpesimen: $totalSpesimen, totalSpesimenNegatif: $totalSpesimenNegatif}';
  }
}

class CovidUpdateModel extends Equatable {
  final int jumlahMeninggal;
  final int jumlahSembuh;
  final int jumlahDirawat;
  final int jumlahPositif;
  final String tanggal;
  final String created;

  CovidUpdateModel({
    this.jumlahMeninggal,
    this.jumlahSembuh,
    this.jumlahDirawat,
    this.jumlahPositif,
    this.tanggal,
    this.created,
  });

  factory CovidUpdateModel.fromJson(Map<String, dynamic> json) {
    return CovidUpdateModel(
      jumlahMeninggal: json['jumlah_meninggal'],
      jumlahSembuh: json['jumlah_sembuh'],
      jumlahDirawat: json['jumlah_dirawat'],
      jumlahPositif: json['jumlah_positif'],
      tanggal: json['tanggal']??'',
      created: json['created']??'',
    );
  }

  @override
  List<Object> get props => [
        jumlahMeninggal,
        jumlahSembuh,
        jumlahDirawat,
        jumlahPositif,
        tanggal,
        created,
      ];

  @override
  String toString() {
    return 'CovidUpdateModel{jumlahMeninggal: $jumlahMeninggal, jumlahSembuh: $jumlahSembuh, jumlahDirawat: $jumlahDirawat, jumlahPositif: $jumlahPositif, tanggal: $tanggal, created: $created}';
  }
}

class CovidProvinsiModel extends Equatable {
  final int jumlahMeninggal;
  final int jumlahSembuh;
  final int jumlahDirawat;
  final String provinsi;
  final int jumlahKasus;
  final String lastDate;

  CovidProvinsiModel({
    this.jumlahMeninggal,
    this.jumlahSembuh,
    this.jumlahDirawat,
    this.provinsi,
    this.jumlahKasus,
    this.lastDate,
  });

  factory CovidProvinsiModel.fromJson(
      Map<String, dynamic> json, String lastDate) {
    return CovidProvinsiModel(
      provinsi: json['key'],
      jumlahMeninggal: json['jumlah_meninggal'],
      jumlahSembuh: json['jumlah_sembuh'],
      jumlahDirawat: json['jumlah_dirawat'],
      jumlahKasus: json['jumlah_kasus'],
      lastDate: lastDate,
    );
  }

  @override
  List<Object> get props => [
        jumlahMeninggal,
        jumlahSembuh,
        jumlahDirawat,
        provinsi,
        jumlahKasus,
      ];

  @override
  String toString() {
    return 'CovidProvinsiModel{jumlahMeninggal: $jumlahMeninggal, jumlahSembuh: $jumlahSembuh, jumlahDirawat: $jumlahDirawat, provinsi: $provinsi, jumlahKasus: $jumlahKasus}';
  }
}
