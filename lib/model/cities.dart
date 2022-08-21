class cities {
  late int id;
  late String nameEn;
 late String nameAr;

  cities({required this.id, required this.nameEn, required this.nameAr});

  cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }
}