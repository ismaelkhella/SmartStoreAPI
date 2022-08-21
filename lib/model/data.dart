import 'package:smartsstors/model/famous_products_home.dart';
import 'package:smartsstors/model/latestprouducthome.dart';

import 'categoryhome.dart';
import 'sliderss.dart';

class Data {
  late List<slidersee> slider;
  late List<Categories> Categorie;
  late List<LatestProducts> latestprouduct;
  late List<famous_products> famousproduct;
  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      Categorie = <Categories>[];
      json['categories'].forEach((v) {
        Categorie.add(Categories.fromJson(v));
      });
    }
    if (json['slider'] != null) {
      slider = <slidersee>[];
      json['slider'].forEach((v) {
        slider.add(slidersee.fromJson(v));
      });
    }

    if (json['famous_products'] != null) {
    famousproduct = <famous_products>[];
    json['famous_products'].forEach((v) {
      famousproduct.add(famous_products.fromJson(v));
    });
    }
    if (json['latest_products'] != null) {
    latestprouduct = <LatestProducts>[];
    json['latest_products'].forEach((v) {
      latestprouduct.add(LatestProducts.fromJson(v));
    });
    }
  }
}
