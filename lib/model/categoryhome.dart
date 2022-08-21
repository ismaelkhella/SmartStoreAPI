class Categories {
  int? id;
  String? nameEn;
  String? nameAr;
  String? image;
  String? imageUrl;

  Categories({this.id, this.nameEn, this.nameAr, this.image, this.imageUrl});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    imageUrl = json['image_url'];
  }
  }