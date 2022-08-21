import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartsstors/Auth/helpers.dart';
import 'package:smartsstors/Auth/listcity.dart';
import 'package:smartsstors/Home/productDescription.dart';
import 'package:smartsstors/Home/productDescriptionnoffer.dart';
import 'package:smartsstors/api/auth_api_controller.dart';
import 'package:smartsstors/model/category.dart';
import 'package:smartsstors/model/categoryhome.dart';
import 'package:smartsstors/model/famous_products_home.dart';
import 'package:smartsstors/model/fvoraiteproduct.dart';
import 'package:smartsstors/model/offer.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';
import 'package:smartsstors/widget/AppTextFieldSearch.dart';
import 'package:smartsstors/widget/app_text_field%20Name.dart';

class FavoriatScreen extends StatefulWidget {
  FavoriatScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FavoriatScreenState createState() => _FavoriatScreenState();
}

class _FavoriatScreenState extends State<FavoriatScreen> with Helpers {
  List<FvoraiteProduct?> favoraiteproducts = <FvoraiteProduct>[];

  //ConnectivityResult? connectivity;
  // StreamSubscription? subscription;
  //var result = Connectivity().checkConnectivity();
  Color _iconColor = Colors.red;
  StreamSubscription? connection;
  bool isoffline = false;
  late Future<List<FvoraiteProduct?>> _futurefavoraite;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    initConnectivity();
    connection = Connectivity()
        .onConnectivityChanged
        .listen((_UpdateConnectionState) {});
    // whenevery connection status is changed.
    // if(result == ConnectivityResult.none){
    //   setState(() {
    //     showsnakbarmassege();
    //   });

    //there is no any connection

    //   }});
    //   // TODO: implement initState
    super.initState();
    _futurefavoraite = AuthApiController().getfavoraite(context);
    // if(result == ConnectivityResult.none){
    //        showsnakbarmassege();
    //    }}
  }

  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(children: [
          Container(
            child: FutureBuilder<List<FvoraiteProduct?>>(
                future: _futurefavoraite,
                builder: (context, snapshot) {
                  favoraiteproducts = snapshot.data ?? [];
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return BildShimmerOffers();
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    if (SharedPrefController().id ==
                        favoraiteproducts[0]!.pivot!.userId&&favoraiteproducts.isNotEmpty) {
                      print('8888888888888888888888888888');
                      return InkWell(
                        child: Stack(children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: favoraiteproducts.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                // Color _iconColor = Colors.blue;
                                return InkWell(
                                    onTap: () {
                                      if(favoraiteproducts[index]!.offerPrice==null){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDescriptionsScreen(
                                                      id: favoraiteproducts[index]!.id!,
                                                      expired: true,
                                                    )));
                                      }else{
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDescriptionsScreenOffer(
                                                      id: favoraiteproducts[index]!.id!,
                                                      image: favoraiteproducts[index]!
                                                          .imageUrl
                                                          .toString(),
                                                    )));
                                      }
                                    },
                                    child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 23, vertical: 20),
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              elevation: 20.0,
                                              shadowColor: Color(0xFFF4E55AF),
                                              child: Container(
                                                height: 90,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF7F7F7),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: ListTile(
                                                  // contentPadding: EdgeInsets.zero,
                                                  leading: Container(
                                                    width: 70,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: Colors.black12,
                                                      image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                          favoraiteproducts[
                                                                  index]!
                                                              .imageUrl
                                                              .toString(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  title: Stack(children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10),
                                                      child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                              ' ${favoraiteproducts[index]!.nameEn.toString()}')),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 50),
                                                        child: Text(
                                                            '${' ' + 'QUANTITY:' + ' ' + favoraiteproducts[index]!.quantity.toString()}')),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 50,
                                                                left: 170),
                                                        child: Text(
                                                            ' ${favoraiteproducts[index]!.price.toString() + '' + '₪'}')),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 170),
                                                      child: IconButton(
                                                          iconSize: 25,
                                                          onPressed: () async {
                                                            await AuthApiController()
                                                                .favoraite(
                                                                    context,
                                                                    product_id:
                                                                        favoraiteproducts[index]!.id);
                                                            setState(() {
                                                              favoraiteproducts[index]!.isFavorite = !favoraiteproducts[index]!.isFavorite!;
                                                              int indexs = favoraiteproducts.indexWhere((element) => element!.id== favoraiteproducts[index]!.id);
                                                              if (indexs != -1) {
                                                                favoraiteproducts.removeAt(indexs);

                                                              };

                                                            });

                                                          },
                                                          icon: favoraiteproducts[index]!
                                                                  .isFavorite!
                                                              ? Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red)
                                                              : Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .grey)),
                                                    ),
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
                        ]),
                      );
                    } else {
                      print(favoraiteproducts[0]!.pivot!.userId);
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.warning,
                              size: 80,
                              color: Colors.grey,
                            ),
                            Text(
                              'No Favourite',
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
                  } else {
                    return  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.warning,
                            size: 80,
                            color: Colors.grey,
                          ),
                          Text(
                            'No Data',
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
                }),
          ),
        ]));
  }

  ListView BildShimmerOffers() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          // Color _iconColor = Colors.blue;
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23, vertical: 20),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          );
        });
  }

  void showsnakbarmassege() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('no internet'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 5),
      dismissDirection: DismissDirection.horizontal,
    ));
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      print("Error Occurred: ${e.toString()} ");
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    if (result == ConnectivityResult.none) {
      return _UpdateConnectionState(result);
    }
  }

  Future<void> _UpdateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      showStatus(result, true);
    } else {
      showStatus(result, false);
    }
  }

  void showStatus(ConnectivityResult result, bool status) {
    final snackBar = SnackBar(
      content: Text('no internet'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 5),
      dismissDirection: DismissDirection.horizontal,
    );
    //SnackBar(
    //     content:
    //     Text("${status ? 'ONLINE\n' : 'OFFLINE\n'}${result.toString()} "),
    //     backgroundColor: status ? Colors.green : Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
