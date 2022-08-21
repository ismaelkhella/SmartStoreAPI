import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartsstors/Auth/listcity.dart';
import 'package:smartsstors/Home/productDescriptionnoffer.dart';
import 'package:smartsstors/api/auth_api_controller.dart';
import 'package:smartsstors/model/category.dart';
import 'package:smartsstors/model/categoryhome.dart';
import 'package:smartsstors/model/famous_products_home.dart';
import 'package:smartsstors/model/offer.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';
import 'package:smartsstors/widget/AppTextFieldSearch.dart';
import 'package:smartsstors/widget/app_text_field%20Name.dart';

class OffersScreen extends StatefulWidget {
  OffersScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  late bool conected;
  List<Offers> offers = <Offers>[];
  late int offerslegnth;
  Color _iconColor = Colors.red;
  late Future<List<Offers>> _futureOffers;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    //   // TODO: implement initState
    super.initState();
    _futureOffers = AuthApiController().getOffers();
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
        body: ListView(shrinkWrap: true, children: [
          Stack(children: [
            Container(
              height: 150,
              color: Color(0xFFF4E55AF),
            ),
            OfflineBuilder(
              connectivityBuilder: (BuildContext context,
                  ConnectivityResult connectivity, Widget child) {
                conected = connectivity != ConnectivityResult.none;
                return Container(
                  width: 400,
                  height: 30,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 350),
                    color: conected ? null : Color(0xFFEE4400),
                    child: conected
                        ? null
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "OFFLINE",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              SizedBox(
                                width: 12.0,
                                height: 12.0,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            ],
                          ),
                  ),
                );
              },
              child: Text('xeaxxea'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 130, left: 40, right: 40),
              child: AppTextFieldSearch(
                  hintText: 'Search Offers ',
                  prefixIcon: Icon(Icons.search),
                  color: Colors.white),
            ),
            Container(
              margin: EdgeInsets.only(top: 300),
              child: FutureBuilder<List<Offers>>(
                  future: _futureOffers,
                  builder: (context, snapshot) {
                    offers = snapshot.data ?? [];
                    offerslegnth = offers.length;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return BildShimmerOffers();
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      print('8888888888888888888888888888');
                      return InkWell(
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top:30),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: offers.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  // Color _iconColor = Colors.blue;
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDescriptionsScreenOffer(
                                                      id: offers[index].productId!,
                                                      image: offers[index]
                                                          .imageUrl
                                                          .toString(),
                                                    )));
                                      },
                                      child: conected
                                          ? Padding(
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
                                                            offers[index]
                                                                .imageUrl
                                                                .toString(),
                                                          ),
                                                        ),
                                                      ),
                                                      // child: Container(
                                                      //   width: 80,
                                                      //   height: 80,
                                                      //   decoration: BoxDecoration(
                                                      //     color: Colors.red,
                                                      //       borderRadius: BorderRadius.circular(15),
                                                      //       image: DecorationImage(
                                                      //         fit: BoxFit.fill,
                                                      //         image: NetworkImage(
                                                      //             _users[index].imageUrl.toString()),
                                                      //       ))),
                                                      // child: Padding(
                                                      //     padding: EdgeInsets.only(
                                                      //         left: 20),
                                                      //     child: IconButton(
                                                      //         icon: Icon(
                                                      //             Icons
                                                      //                 .shopping_cart,
                                                      //             color: offers[
                                                      //                         index]
                                                      //                     .iconprees!
                                                      //                 ? Colors.green
                                                      //                 : Colors.red),
                                                      //         onPressed: () {
                                                      //           setState(() {
                                                      //             offers[index]
                                                      //                     .iconprees =
                                                      //                 !offers[index]
                                                      //                     .iconprees!;
                                                      //             // _iconColor =
                                                      //             // _iconColor == Colors.red ? Colors.yellow : Colors.red;
                                                      //           });
                                                      //         })),
                                                    ),
                                                    title: Stack(children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top: 10),
                                                        child: Align(
                                                            alignment:
                                                                Alignment.topLeft,
                                                            child: Text(
                                                                ' ${offers[index].nameEn.toString()}')),
                                                      ),
                                                      Padding(
                                                          padding: EdgeInsets.only(
                                                              top: 50),
                                                          child: Text(
                                                              '${' ' + 'discount:' + ' ' + offers[index].discountPrice.toString()}')),
                                                      Container(
                                                          width: 100,
                                                          margin: EdgeInsets.only(
                                                              top: 53, left: 120),
                                                          child: Divider(
                                                            color: Colors.red,
                                                          )),
                                                      Padding(
                                                          padding: EdgeInsets.only(
                                                              top: 50, left: 120),
                                                          child: Text(
                                                              ' ${'original:' + ' ' + offers[index].originalPrice.toString()}')),
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.only(top: 10,right: 10),
                                                            child: Text(
                                                                offers[index]
                                                                        .expired!
                                                                    ? 'expired'
                                                                    : 'available')),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 23, vertical: 20),
                                                child: Container(
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF7F7F7),
                                                    borderRadius:
                                                        BorderRadius.circular(15),
                                                  ),
                                                ),
                                              ),
                                            ));
                                }),
                            ),
                    Padding(
                    padding: EdgeInsets.only(left: 23),
                    child: Text(
                    offers.length.toString() + ' ' + 'Offer available',
                    style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                        ]),
                      );
                    } else {
                      return BildShimmerOffers();
                    }
                  }),
            ),
          ]),
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
}
