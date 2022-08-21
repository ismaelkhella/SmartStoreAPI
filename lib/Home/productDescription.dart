import 'dart:ffi';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:smartsstors/Auth/listcity.dart';
import 'package:smartsstors/Auth/sheet_code_activation.dart';
import 'package:smartsstors/api/auth_api_controller.dart';
import 'package:smartsstors/model/category.dart';
import 'package:smartsstors/model/categoryhome.dart';
import 'package:smartsstors/model/famous_products_home.dart';
import 'package:smartsstors/model/offer.dart';
import 'package:smartsstors/model/productonesearch.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';
import 'package:smartsstors/widget/AppTextFieldSearch.dart';
import 'package:smartsstors/widget/app_text_field%20Name.dart';

import '../Auth/helpers.dart';
import '../controller_Db/contact.dart';
import '../controller_Db/contact_provider.dart';

class ProductDescriptionsScreen extends StatefulWidget {
  ProductDescriptionsScreen({
    Key? key,
    required this.id,
    required this.expired,
  }) : super(key: key);
  final int id;
  final bool expired;

  @override
  _ProductDescriptionsScreenState createState() =>
      _ProductDescriptionsScreenState();
}

class _ProductDescriptionsScreenState extends State<ProductDescriptionsScreen>
    with Helpers {
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
  int? idproducte;
  int? priceproduct;
  String? nameproduct;
  String? imageproduct;
  late bool conected;
  int addcart = 0;
  bool checadd = false;
  int idproductdelet = 0;
  List<Objectproductone> objectbroducts = <Objectproductone>[];
  late Future<Objectproductone?> _futureProduct;
  late List<int> idproduct = <int>[];
  List<famous_products> famous = <famous_products>[];
  int _courntpageindex = 0;
  late String id;
  late int quantitiytouser = 1;
  late Offers off;
  double rate = 3;
  int prise = 0;
  int discountebroduct = 0;
  late bool onpress = false;
  Color _iconColor = Colors.red;
  List<int> leangh = <int>[];
  bool _show = false;
  Objectproductone objectproduct=Objectproductone();

  void initState() {
    //   // TODO: implement initState
    super.initState();
    Provider.of<ContactProvider>(context, listen: false).read();
    _futureProduct = AuthApiController().getProductone(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF4E55AF),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        backgroundColor: const Color(0XFFFEEF6F6),
        body: FutureBuilder<Objectproductone?>(
            future: _futureProduct,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildShimmerCategory();
              } else if (snapshot.hasData) {
                objectbroducts.add(snapshot.data!);
                objectproduct=objectbroducts[0];
                // priceproduct = objectbroducts[0].price;
                // nameproduct = objectbroducts[0].nameEn;
                // imageproduct = objectbroducts[0].imageUrl;
                // idproducte = objectbroducts[0].id;
                if (objectbroducts[0].overalRate! > 0) {
                  rate = objectbroducts[0].overalRate!.toDouble();
                } else {
                  rate = 1;
                }
                if (widget.expired == false) {
                  discountebroduct = 100 -
                      (objectbroducts[0].offerPrice! *
                              100 /
                              objectbroducts[0].price!)
                          .toInt();
                  prise = objectbroducts[0].offerPrice!;
                } else {
                  discountebroduct = 0.toInt();
                  prise = objectbroducts[0].price!;
                }
                return ListView(children: [
                  Stack(children: [
                    Container(
                      color: const Color(0xFFF4E55AF),
                      height: 300,
                    ),
                    CarouselSlider.builder(
                        itemCount: 3,
                        options: CarouselOptions(
                          onPageChanged: (index, value) {
                            setState(() {
                              _courntpageindex = index;
                            });
                          },
                          //enlargeCenterPage: true,
                          height: 500,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          reverse: false,
                          aspectRatio: 5.0,
                          viewportFraction: 1.0,
                          //       aspectRatio: 2,
                        ),
                        itemBuilder: (context, i, id) {
                          return GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 60, horizontal: 20),
                              child: SimpleShadow(
                                  opacity: 0.6,
                                  // Default: 0.5
                                  color: Colors.blue,
                                  // Default: Black
                                  offset: const Offset(30, 30),
                                  // Default: Offset(2, 2)
                                  sigma: 7,
                                  child: Image.network(
                                    objectbroducts[0]
                                        .images![i]
                                        .imageUrl
                                        .toString(),
                                    height: 150,
                                  )),
                            ),
                          );
                        }),
                    Container(
                      margin: const EdgeInsets.only(top: 270, left: 180),
                      height: 8,
                      child: GridView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 3,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _courntpageindex == index
                                  ? Colors.blue
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 300),
                        child: Material(
                            borderRadius: BorderRadius.circular(15),
                            elevation: 20.0,
                            shadowColor: const Color(0xFFF4E55AF),
                            child: Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                color: Color(0XFFF5E6297),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                              ),
                            ))),
                    Padding(
                        padding: const EdgeInsets.only(top: 350, left: 15),
                        child: Material(
                            borderRadius: BorderRadius.circular(15),
                            elevation: 20.0,
                            shadowColor: const Color(0xFFF4E55AF),
                            child: Container(
                              height: 40,
                              width: 90,
                              decoration: BoxDecoration(
                                color: const Color(0XFFFFCBF02),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(discountebroduct.toString() +
                                      '%' +
                                      'off')),
                            ))),
                    Padding(
                      padding: const EdgeInsets.only(top: 320, left: 20),
                      child: Text(
                        objectbroducts[0].nameEn.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 360, left: 120),
                      child: Text(
                        prise.toString(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF97D4A4)),
                      ),
                    ),
                    // Container(
                    //     width: 60,
                    //     margin: EdgeInsets.only(top: 420, left: 140),
                    //     child: Divider(
                    //       color: Colors.red,
                    //     )),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 420, left: 150),
                    //   child: Text(
                    //     objectbroducts[0].isFavorite.toString(),
                    //     style: TextStyle(
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.bold,
                    //         color: Color(0xFFFC1CCD8)),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 360, left: 220),
                      child: RatingBar.builder(
                        initialRating: rate,
                        minRating: rate,
                        maxRating: rate,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        updateOnDrag: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          rating = rate;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 310, left: 325),
                      child: IconButton(
                        iconSize: 30,
                        onPressed: () async {
                          await AuthApiController().favoraite(context,
                              product_id: objectbroducts[0].id);
                          setState(() => objectbroducts[0].isFavorite =
                              !objectbroducts[0].isFavorite!);
                        },
                        icon: objectbroducts[0].isFavorite!
                            ? const Icon(Icons.favorite, color: Colors.red)
                            : const Icon(Icons.favorite_border, color: Colors.black),
                      ),
                    ),
                    Container(
                        child: Padding(
                            padding: const EdgeInsets.only(top: 430),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade100,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(50),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              height: 200,
                              child: ListView(children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Quantity',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                Stack(children: [
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(left: 280, top: 20),
                                      child: FloatingActionButton(
                                          heroTag: 'remove',
                                          onPressed: () {
                                            setState(() {
                                              quantitiytouser++;
                                            });
                                          },
                                          child: const Text(
                                            '+',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          backgroundColor: const Color(0xFFF4E55AF))),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(top: 20, left: 70),
                                      child: FloatingActionButton(
                                        heroTag: 'add',
                                        onPressed: () {
                                          setState(() {
                                            if (quantitiytouser > 1)
                                              quantitiytouser--;
                                          });
                                        },
                                        child: const Text(
                                          '-',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        backgroundColor: const Color(0xFFF4E55AF),
                                      )),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 40, left: 200),
                                    child: Text(
                                      quantitiytouser.toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.only(top: 100, left: 20),
                                      child: Text(
                                        'Product Description :',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 130, left: 20, right: 10),
                                      child: Text(
                                        objectbroducts[0].infoEn.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ))
                                ]),
                              ]),
                            ))),
                    Consumer<ContactProvider>(builder:
                        (BuildContext context, ContactProvider value, child) {
                        for (int i = 0; i < value.contact.length; i++) {
                          if (objectbroducts[0].id ==
                              value.contact[i].idproduct&&SharedPrefController().id==value.contact[i].iduser) {
                            checadd = true;
                            idproductdelet = value.contact[i].id;
                          }
                        }
                        return Stack(children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 650, left: 200, right: 10),
                              child: Container(
                                  width: 200,
                                  height: 50,
                                  decoration:  BoxDecoration(
                                    color: checadd? Colors.red: Color(0xFF4E55AF),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                  ),
                                  child: TextButton(
                                      //       child: const Text('LOGIN'),
                                      //       style: ElevatedButton.styleFrom(
                                      //         minimumSize: const Size(500,56),
                                      onPressed: () async {
                                        if (checadd == false) {
                                          await save();
                                        } else {
                                          await delet(idproductdelet);
                                        }
                                        setState(() {
                                          checadd = !checadd;
                                        });
                                      },
                                      child: Text(checadd
                                          ? 'remove cart'
                                          : 'Add to cart'
                                      ,style: TextStyle(color: Colors.white),)
                                  ))),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 650),
                            child: IconButton(
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: checadd ? Colors.green : Colors.red,
                                  size: 40,
                                ),
                                onPressed: () {}),
                          ),
                        ]);

                    }),
                  ])
                ]);
              } else {
                return buildShimmerCategory();
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
            padding: const EdgeInsets.only(top: 360),
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
            )),
        Container(
            child: Padding(
                padding: const EdgeInsets.only(top: 480),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: const BorderRadius.only(
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

  Future<void> save() async {
    bool creat = await Provider.of<ContactProvider>(context, listen: false)
        .creat(c: cart);
    if (creat) {
      showSnackBar(context: context, message: 'pass', error: false);
    } else {
      showSnackBar(context: context, message: 'no paas', error: false);
    }
  }

  Future<void> delet(int id) async {
    bool delet =
        await Provider.of<ContactProvider>(context, listen: false).delet(id);
    if (delet) {
      showSnackBar(context: context, message: 'pass delet', error: false);
    } else {
      showSnackBar(context: context, message: 'no paas delete', error: false);
    }
  }

  Informationcart get cart {
    Informationcart informcart = Informationcart();
    informcart.name = objectproduct.nameEn.toString();
    informcart.price = objectproduct.price!;
    informcart.count = quantitiytouser;
    informcart.image = objectproduct.imageUrl.toString();
    informcart.idproduct = objectproduct.id!;
    informcart.quantity = objectproduct.quantity!;
    informcart.infoEn = objectproduct.infoEn!;
    informcart.infoAr = objectproduct.infoAr!;
    informcart.overalRate = objectproduct.overalRate!;
    informcart.productRate = objectproduct.productRate!;
    informcart.offerPrice = objectproduct.offerPrice==null?0:objectproduct.offerPrice!;
    informcart.subCategoryId = objectproduct.subCategoryId!;
    informcart.nameAr = objectproduct.nameAr!;
    informcart.isFavorite = objectproduct.isFavorite!?1:0;
    informcart.iduser =SharedPrefController().id;
    return informcart;
  }
}
