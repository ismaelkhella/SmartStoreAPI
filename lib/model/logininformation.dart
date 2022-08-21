import 'package:smartsstors/model/userstore.dart';

class Logininformation {
  bool? status;
  String? message;
  UserStore? data;

  Logininformation({this.status, this.message, this.data});

  Logininformation.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserStore.fromJson(json['data']) : null;
  }}
