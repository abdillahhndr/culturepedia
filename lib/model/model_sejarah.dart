// To parse this JSON data, do
//
//     final modelSejarah = modelSejarahFromJson(jsonString);

import 'dart:convert';

ModelSejarah modelSejarahFromJson(String str) =>
    ModelSejarah.fromJson(json.decode(str));

String modelSejarahToJson(ModelSejarah data) => json.encode(data.toJson());

class ModelSejarah {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelSejarah({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelSejarah.fromJson(Map<String, dynamic> json) => ModelSejarah(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String nama;
  String foto;
  String tglLhr;
  String asal;
  String jenisKelamin;
  String deskripsi;

  Datum({
    required this.id,
    required this.nama,
    required this.foto,
    required this.tglLhr,
    required this.asal,
    required this.jenisKelamin,
    required this.deskripsi,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nama: json["nama"],
        foto: json["foto"],
        tglLhr: json["tgl_lhr"],
        asal: json["asal"],
        jenisKelamin: json["jenis_kelamin"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "foto": foto,
        "tgl_lhr": tglLhr,
        "asal": asal,
        "jenis_kelamin": jenisKelamin,
        "deskripsi": deskripsi,
      };
}
