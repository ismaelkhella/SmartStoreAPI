import 'dart:ffi';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:smartsstors/Auth/listcity.dart';
import 'package:smartsstors/Auth/sheet_code_activation.dart';
import 'package:smartsstors/Home/productDescription.dart';
import 'package:smartsstors/api/auth_api_controller.dart';
import 'package:smartsstors/model/category.dart';
import 'package:smartsstors/model/categoryhome.dart';
import 'package:smartsstors/model/famous_products_home.dart';
import 'package:smartsstors/model/offer.dart';
import 'package:smartsstors/widget/AppTextFieldSearch.dart';
import 'package:smartsstors/widget/app_text_field%20Name.dart';

class ProductDescriptionsScreenOffer extends StatefulWidget {
  ProductDescriptionsScreenOffer({
    Key? key,
    required this.id,
    required this.image,
  }) : super(key: key);
  final int id;
  final String image;

  @override
  _ProductDescriptionsScreenState createState() =>
      _ProductDescriptionsScreenState();
}

class _ProductDescriptionsScreenState extends State<ProductDescriptionsScreenOffer>
    with Sheetcodeactivation {
  final List<String> imageList = [
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_ 960_720.jpg",
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvF0FPptHCMaOTf1uV_RLDtD4-yQY4RlHQZA&usqp=CAU',
    'https://msry.org/wp-content/uploads/%D8%B5%D9%88%D8%B1-%D8%AD%D9%84%D9%88%D8%A9-4-1.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvF0FPptHCMaOTf1uV_RLDtD4-yQY4RlHQZA&usqp=CAU',
    'https://ccute.cc/wp-content/uploads/2018/07/5378.jpg',
    'https://1.bp.blogspot.com/-rJ_MNOEc5ko/XatbhMou1cI/AAAAAAAABjY/WolXP6btEVkbxNEy8T9CLa5KCuobO7bkwCEwYBhgL/s1600/hdoaa.com%2B%25D8%25B5%25D9%2588%25D8%25B1%2B%25D8%25AE%25D9%2584%25D9%2581%25D9%258A%25D8%25A7%25D8%25AA%2B%25D8%25B7%25D8%25A8%25D9%258A%25D8%25B9%25D9%258A%25D8%25A9%2B%25282%2529.jpg'
  ];
  late bool conected;
  List<Offers> offers = <Offers>[];
  late Future<List<Category>> _future1;
  late List<int> idproduct = <int>[];
  List<famous_products> famous = <famous_products>[];
  int _courntpageindex = 0;
  late String id;
  late int quantitiytouser = 1;
  late Offers off;
  late bool onpress = false;
  Color _iconColor = Colors.red;
  List<Offers> objectProductoffer = <Offers>[];
  List<int> leangh = <int>[];
  bool _show = false;
  late Future<List<Offers>> _futuroffers;

  void initState() {
    //   // TODO: implement initState
    super.initState();
    _future1 = AuthApiController().getCategories();
    _futuroffers = AuthApiController().getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFFF4E55AF),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context),
            )),
        backgroundColor: Color(0XFFFEEF6F6),
        body: FutureBuilder<List<Offers>>(
            future: _futuroffers,
            builder: (context, snapshot) {
              offers = snapshot.data ?? [];
              offers.forEach((element) {
                if (element.productId == widget.id) {
                  objectProductoffer.add(element);
                  leangh.add(offers.length);
                }
              });
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildShimmerCategory();
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView(children: [
                  Stack(children: [
                    Container(
                      color: Color(0xFFF4E55AF),
                      height: 330,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                      child: SimpleShadow(
                        opacity: 0.6,
                        // Default: 0.5
                        color: Colors.blue,
                        // Default: Black
                        offset: Offset(30, 30),
                        // Default: Offset(2, 2)
                        sigma: 7,
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: Image.network(
                              widget.image.toString(),
                              height: 150,
                            )),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 300),
                        child: Material(
                            borderRadius: BorderRadius.circular(15),
                            elevation: 20.0,
                            shadowColor: Color(0xFFF4E55AF),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0XFFF5E6297),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                              ),
                            ))),
                    Padding(
                        padding: EdgeInsets.only(top: 350, left: 15),
                        child: Material(
                            borderRadius: BorderRadius.circular(15),
                            elevation: 20.0,
                            shadowColor: Color(0xFFF4E55AF),
                            child: Container(
                              height: 40,
                              width: 90,
                              decoration: BoxDecoration(
                                color: Color(0XFFFFCBF02),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(objectProductoffer[0]
                                          .discountRatio
                                          .toString() +
                                      '%' +
                                      'off')),
                            ))),
                    Padding(
                      padding: EdgeInsets.only(top: 340,left: 280),
                      child: Text(objectProductoffer[0].expired!
                          ? 'expired'
                          : 'available',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 320, left: 20),
                      child: Text(
                        objectProductoffer[0].nameEn.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 350, left: 120),
                      child: Text(
                        objectProductoffer[0].discountPrice.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF97D4A4)),
                      ),
                    ),
                    Container(
                        width: 60,
                        margin: EdgeInsets.only(top: 370, left: 140),
                        child: Divider(
                          color: Colors.red,
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 370, left: 150),
                      child: Text(
                        objectProductoffer[0].originalPrice.toString(),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFC1CCD8)),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 410, left: 220),
                    //   child: RatingBar.builder(
                    //     initialRating: 3,
                    //     minRating: 1,
                    //     direction: Axis.horizontal,
                    //     allowHalfRating: true,
                    //     itemCount: 5,
                    //     itemSize: 20,
                    //     itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    //     itemBuilder: (context, _) => Icon(
                    //       Icons.star,
                    //       color: Colors.amber,
                    //     ),
                    //     onRatingUpdate: (rating) {
                    //       print(rating);
                    //     },
                    //   ),
                    // ),

                    Container(
                        child: Padding(
                            padding: EdgeInsets.only(top: 420),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade100,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(50),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              height: 230,
                              child: ListView(children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Product info',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                Stack(children: [
                                  Padding(
                                      padding:
                                      EdgeInsets.only(top: 50, left: 20),
                                      child: Text(
                                        'start_date : '+objectProductoffer[0].startDate.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )), Padding(
                                      padding:
                                      EdgeInsets.only(top: 90, left: 20),
                                      child: Text(
                                        'end_date : '+objectProductoffer[0].endDate.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),

                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: 130, left: 20),
                                      child: Text(
                                        'Product Description :',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 160, left: 20),
                                      child: Text(
                                        objectProductoffer[0].infoEn.toString()+'\n',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ))
                                ]),
                              ]),
                            ))),
                    Padding(
                      padding: EdgeInsets.only(top: 660, left: 110, right: 10),
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF4E55AF),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        child: TextButton(
                            child: Text('go to the product'),
                          //       child: const Text('LOGIN'),
                          //       style: ElevatedButton.styleFrom(
                          //         minimumSize: const Size(500,56),
                          onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                               ProductDescriptionsScreen(id:objectProductoffer[0].productId!,expired: objectProductoffer[0].expired!,)));
                          }
                        ),
                      ),
                    ),

                  ]),
                ]);
              } else {
                return  buildShimmerCategory();
              }
            }));
  }

  Shimmer buildShimmerCategory() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
              child: Stack(children: [
                Container(
                    height: 350,
                  color: Colors.grey,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 360),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color:Colors.grey,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                        )),
                Container(
            child: Padding(
                padding: EdgeInsets.only(top: 480),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(10)),
                  ),
                  height: 230,
                ))),
      ]),
    );
  }
}
