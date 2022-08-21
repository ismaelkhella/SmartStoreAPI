class Informationcart {
  late int id;
  late String image;
  late String name;
  late int count;
  late int price;
  late int idproduct;
 late String nameAr;
 late String infoEn;
 late String infoAr;
  late int quantity;
  late int overalRate;
  late int subCategoryId;
  late int productRate;
  late int offerPrice;
  late int isFavorite;
  late int iduser;

  Informationcart();

  Informationcart.fromMap(Map<String, dynamic> rowmap) {
    id = rowmap['id'];
     name= rowmap['name'];
    image = rowmap['image'];
    price = rowmap['price'];
    count = rowmap['count'];
    idproduct = rowmap['idproduct'];
    quantity = rowmap['quantity'];
    nameAr = rowmap['nameAr'];
    infoEn = rowmap['infoEn'];
    infoAr = rowmap['infoAr'];
    overalRate = rowmap['overalRate'];
    subCategoryId = rowmap['subCategoryId'];
    productRate = rowmap['productRate'];
    offerPrice = rowmap['offerPrice'];
    isFavorite = rowmap['isFavorite'];
    iduser = rowmap['iduser'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> rowMap = <String, dynamic>{};
    // rowMap['id']=id;
    rowMap['name'] = name;
    rowMap['image'] = image;
    rowMap['price'] = price;
    rowMap['count'] = count;
    rowMap['idproduct']=idproduct;
    rowMap['quantity']=quantity;
    rowMap['nameAr']=nameAr;
    rowMap['infoEn']=infoEn;
    rowMap['infoAr']=infoAr;
    rowMap['overalRate']=overalRate;
    rowMap['subCategoryId']=subCategoryId;
    rowMap['productRate']=productRate;
    rowMap['offerPrice']=offerPrice;
    rowMap['isFavorite']=isFavorite;
    rowMap['iduser']=iduser;

    return rowMap;
  }
}
