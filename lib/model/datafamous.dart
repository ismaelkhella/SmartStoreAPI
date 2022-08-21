import 'package:smartsstors/model/famous_products_home.dart';
import 'package:smartsstors/model/latestprouducthome.dart';

import 'categoryhome.dart';
import 'sliderss.dart';

class Datafamus {
  late List<slidersee>slider;
  late List<Categories>Categorie;
  late List<LatestProducts>latestprouduct;
  late List<famous_products>famousproduct;


  Datafamus.fromJson(Map<String, dynamic> json) {
    if (json['famous_products'] != null) {
      famousproduct = <famous_products>[];
      json['famous_products'].forEach((v) {
        famousproduct.add(famous_products.fromJson(v));
      });
    }

  }


}
