import 'package:smartsstors/model/productsmodel.dart';

class Productsubcategory{
 late bool status;
  late String message;
  late List<Productsmodel> list;

 Productsubcategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      list = <Productsmodel>[];
      json['list'].forEach((v) {
        list.add(Productsmodel.fromJson(v));
      });
    }
  }}
