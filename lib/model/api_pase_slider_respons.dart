import 'package:smartsstors/model/slider.dart';

class ResponsSlider {
  late bool? status;
  late String? message;
  late List<Sliders>? data;
  ResponsSlider.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Sliders>[];
      json['slider'].forEach((v) {
        data?.add(Sliders.fromJson(v));
      });
    }
  }}

