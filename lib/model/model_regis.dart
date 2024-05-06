// To parse this JSON data, do
//
//     final modelRegister = modelRegisterFromJson(jsonString);

import 'dart:convert';

ModelRegister modelRegisterFromJson(String str) =>
    ModelRegister.fromJson(json.decode(str));

String modelRegisterToJson(ModelRegister data) => json.encode(data.toJson());

class ModelRegister {
  int value;
  String username;
  String email;
  String message;

  ModelRegister({
    required this.value,
    required this.username,
    required this.email,
    required this.message,
  });

  factory ModelRegister.fromJson(Map<String, dynamic> json) => ModelRegister(
        value: json["value"],
        username: json["username"],
        email: json["email"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "username": username,
        "email": email,
        "message": message,
      };
}
