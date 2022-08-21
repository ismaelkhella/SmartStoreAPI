import 'sliderss.dart';
import 'data.dart';

class MainHome {
  late bool status;
  late String message;
  late Data data;

  MainHome.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }
  }
}
