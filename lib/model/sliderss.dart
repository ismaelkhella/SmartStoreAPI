class slidersee{
  late int id;
  late String objectId;
 late String url;
  late String imageUrl;

  slidersee({required this.id, required this.objectId, required this.url, required this.imageUrl});

  slidersee.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  objectId = json['object_id'];
  url = json['url'];
  imageUrl = json['image_url'];
  }}