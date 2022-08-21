import 'package:smartsstors/model/cities.dart';

class ApiBaseResponse {
  late bool status;
 late String message;
 late List<cities> list;



  ApiBaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      list = <cities>[];
      json['list'].forEach((v) {
        list.add(cities.fromJson(v));
      });
    }
  }}