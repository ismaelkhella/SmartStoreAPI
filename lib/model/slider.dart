import 'package:smartsstors/model/listproduct.dart';

class Sliders {
  int? id;
  int? objectId;
  String? url;
  String? imageUrl;

  Sliders({this.id, this.objectId, this.url, this.imageUrl});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    objectId = json['object_id'];
    url = json['url'];
    imageUrl = json['image_url'];
  }}