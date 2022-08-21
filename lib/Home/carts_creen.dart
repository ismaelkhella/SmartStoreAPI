import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartsstors/Auth/helpers.dart';
import 'package:smartsstors/controller_Db/contact.dart';
import 'package:smartsstors/model/fvoraiteproduct.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';

import '../controller_Db/contact_provider.dart';
import 'model.dart';

class CartScreen extends StatefulWidget {
  CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with Helpers {
  List<FvoraiteProduct?> favoraiteproducts = <FvoraiteProduct>[];

  //ConnectivityResult? connectivity;
  // StreamSubscription? subscription;
  //var result = Connectivity().checkConnectivity();
  Color _iconColor = Colors.red;
  StreamSubscription? connection;
  bool isoffline = false;
  List<Map> c = <Map>[];
  bool download = false;
  int Totle = 0;
  int i = 0;
  int inter = 0;
  bool ff=false;
  List<int> f = <int>[];

  List<Informationcart> cartinform = <Informationcart>[];
  late Future<List<FvoraiteProduct?>> _futurefavoraite;

  // Map? f;
  // String h='"product_id"';
  // String k='"quantity"';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    //   // TODO: implement initState
    super.initState();
    Provider.of<ContactProvider>(context, listen: false).read();

    // if(result == ConnectivityResult.none){
    //        showsnakbarmassege();
    //    }}
  }

  @override
  Widget build(BuildContext context) {
    double landscape = MediaQuery.of(context).size.height;
    double portrait = MediaQuery.of(context).size.width;
    double Landscape = landscape;
    double Portrait = portrait;
    return Scaffold(
        extendBodyBehindAppBar:false,
        key: _scaffoldKey,
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
            },
          ),
        ),
        body: Stack(children: [
          Container(child: Consumer<ContactProvider>(
              builder: (BuildContext context, ContactProvider value, child) {
            if (cartinform.isEmpty) {
              for (int i = 0; i < value.contact.length; i++) {
                if (value.contact[i].iduser == SharedPrefController().id) {
                  cartinform.add(value.contact[i]);
                }
              }
            }

            if (cartinform.isNotEmpty) {
              if(i<1){
                calculateTotal();
                i++;
              }

              // for(int ii=0;ii<cartinform.length;ii++){
              //   if(i<cartinform.length){
              //    Totle+=cartinform[ii].count*cartinform[ii].price;
              //    i++;
              //  }
              //  }
              //print(value.contact.length.toString() + 'ekkkkkkkkkkkkkkkkkk');
              // print(cartinform.length);
              return InkWell(
                child: Stack(children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartinform.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        // Map f={"product_id":cartinform[index].idproduct};
                        // c.add({"$h":cartinform[index].idproduct,"$k":cartinform[index].quantity});
                        // print(c);
                        // Color _iconColor = Colors.blue;
                        return InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Material(
                              borderRadius: BorderRadius.circular(15),
                              elevation: 20.0,
                              shadowColor: const Color(0xFFF4E55AF),
                              child: Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF7F7F7),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  // contentPadding: EdgeInsets.zero,
                                  leading: Container(
                                    width: 70,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black12,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          cartinform[index].image.toString(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Stack(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              ' ${cartinform[index].price}')),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 50),
                                        child: Text(
                                            '${' ' + 'QUANTITY:' + ' ' + cartinform[index].quantity.toString()}')),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 40, left: 130),
                                        child: Container(
                                          width: Portrait * 0.373,
                                          height: Landscape * 0.055,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF4E55AF),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Stack(children: [
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (cartinform[index].count >
                                                      1) {
                                                    cartinform[index].count--;
                                                    Totle = Totle -
                                                        (cartinform[index]
                                                            .price);
                                                  }
                                                });
                                              },
                                              child: const Text(
                                                '-',
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 66, top: 13),
                                              child: Text(
                                                cartinform[index]
                                                    .count
                                                    .toString(),
                                                style: const TextStyle(
                                                    color:
                                                        Color(0xFFFFFA1DBF5)),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 90),
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    cartinform[index].count++;
                                                    Totle = Totle +
                                                        (cartinform[index]
                                                            .price);
                                                    ff=true;
                                                  });
                                                },
                                                child: const Text(
                                                  '+',
                                                  style:
                                                      TextStyle(fontSize: 19),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        )),
                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //       left: 170),
                                    // child: IconButton(
                                    //     iconSize: 25,
                                    //     onPressed: () async {
                                    //       setState(() {
                                    //
                                    //       });
                                    //
                                    //     },
                                    //     icon: cartinform[index].isFavorite==0
                                    //         ? Icon(
                                    //         Icons.delete,
                                    //         color: Colors
                                    //             .red)
                                    //         : Icon(
                                    //         Icons.delete,
                                    //         color: Colors
                                    //             .grey)),
                                    //),
                                    // Align(
                                    //   alignment:
                                    //   Alignment.topRight,
                                    //   child: Padding(
                                    //       padding:
                                    //       EdgeInsets.only(
                                    //           top: 10,
                                    //           right: 10),
                                    //       child: Text(
                                    //           offers[index]
                                    //               .expired!
                                    //               ? 'expired'
                                    //               : 'available')),
                                    // ),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                          // : Shimmer.fromColors(
                          //     baseColor: Colors.grey[300]!,
                          //     highlightColor: Colors.grey[100]!,
                          //     child: Padding(
                          //       padding: EdgeInsets.symmetric(
                          //           horizontal: 23, vertical: 20),
                          //       child: Container(
                          //         height: 90,
                          //         decoration: BoxDecoration(
                          //           color: Color(0xFFF7F7F7),
                          //           borderRadius:
                          //               BorderRadius.circular(15),
                          //         ),
                          //       ),
                          //     ),
                          //   )
                        );
                      }),


                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      margin: EdgeInsets.all(15),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Total',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(width: 10),
                            Spacer(),
                            Chip(
                              label: Text(Totle.toString() + '.00',
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Color(0xFF4E55AF),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: Portrait * 0.393,
                              height: Landscape * 0.064,
                              decoration: BoxDecoration(
                                color: Color(0xFF4E55AF),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    download = true;
                                  });
                                  Future.delayed(const Duration(seconds: 3),
                                      () {
                                    Navigator.pushNamed(
                                        context, '/offersscreen');
                                  });
                                },
                                child: Text('Order Now',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            SizedBox(width: 10),
                            download ? CircularProgressIndicator() : Text(''),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // child: Card(
                  //   margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  //   child: Padding(
                  //     padding: EdgeInsets.all(8),
                  //     child: ListTile(
                  //       leading: CircleAvatar(
                  //         child: Padding(
                  //           padding: EdgeInsets.all(5),
                  //           child: FittedBox(
                  //             child: Text('15'),
                  //           ),
                  //         ),
                  //       ),
                  //       title: Text('xxe'),
                  //       subtitle: Text('Total:'+'xeaxe'),
                  //       trailing: Text('X'),
                  //     ),
                  //   ),
                  // ),
                ]),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text('uhuhuh'),
                      onPressed: () async {
                        await save();
                      },
                    ),
                    Icon(
                      Icons.warning,
                      size: 80,
                      color: Colors.grey,
                    ),
                    Text(
                      'No cart',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              );
            }
          })),
        ]));
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

  Informationcart get cart {
    Informationcart informcart = Informationcart();
    informcart.name = 'app';
    informcart.price = 10;
    informcart.count = 3;
    informcart.image = '';
    informcart.idproduct = 779;
    informcart.quantity = 300;
    informcart.infoEn = 'lxwmlxlwmlxw';
    informcart.infoAr = 'xwl,xmwlmlxw';
    informcart.overalRate = 3;
    informcart.productRate = 4;
    informcart.offerPrice = 4;
    informcart.subCategoryId = 400;
    informcart.nameAr = 'xle,lx,el,';
    informcart.isFavorite = 1;
    informcart.iduser = SharedPrefController().id;
    return informcart;
  }
  void calculateTotal(){
    cartinform.forEach((element) {
      Totle += element.count * element.price;
    });
  }

  }

