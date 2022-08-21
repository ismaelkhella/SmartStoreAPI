import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:smartsstors/Home/productsubcategory.dart';
import 'package:smartsstors/api/auth_api_controller.dart';
import 'package:smartsstors/model/listproduct.dart';
import 'package:smartsstors/widget/AppTextFieldSearch.dart';

class SubCategoryScreen extends StatefulWidget {
  SubCategoryScreen(
      {Key? key,
      required this.id,
      required this.image,
      required this.categoryname})
      : super(key: key);
  final int id;
  final String image;
  final String categoryname;

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  late bool conected;
  List<ListSubcategory> subcategorys = <ListSubcategory>[];
  List<int> subcategorysleangth = <int>[];
  late int offerslegnth;
  late int leanthsubcategorys = 0;
  late Future<List<ListSubcategory>> _futuresubcategorys;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _futuresubcategorys = AuthApiController().getSupcategory(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: () => Navigator.pop(context),
            )),
        body: ListView(shrinkWrap: true, children: [
          Stack(children: [
            Container(
              height: 250,
              color: const Color(0xFFF4E55AF),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 20),
              child: SimpleShadow(
                opacity: 0.6,
                color: Colors.blue,
                offset: const Offset(30, 30),
                sigma: 7,
                child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 100),
                    child: Image.network(
                      widget.image.toString(),
                      height: 150,
                    )),
              ),
            ),

            // color: Color(0xFFF4E55AF)

            OfflineBuilder(
              connectivityBuilder: (BuildContext context,
                  ConnectivityResult connectivity, Widget child) {
                conected = connectivity != ConnectivityResult.none;
                return Container(
                  width: 400,
                  height: 30,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    color: conected ? null : const Color(0xFFEE4400),
                    child: conected
                        ? null
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
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
              child: const Text('xeaxxea'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 230, left: 40, right: 40),
              child: AppTextFieldSearch(
                  hintText: 'Search sub categories ',
                  prefixIcon: Icon(Icons.search),
                  color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.only(top: 350),
              child: FutureBuilder<List<ListSubcategory>>(
                  future: _futuresubcategorys,
                  builder: (context, snapshot) {
                    subcategorys = snapshot.data ?? [];
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return BildShimmerOffers();
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      print('8888888888888888888888888888');
                      return Stack(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 40, left: 20, right: 20),
                          child: Material(
                            borderRadius: BorderRadius.circular(15),
                            elevation: 20.0,
                            shadowColor: Colors.white,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                              ),
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: subcategorys.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    // Color _iconColor = Colors.blue;
                                    return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductSubCategoryScreen(
                                                        id: subcategorys[index]
                                                            .id!,
                                                        categoryname:
                                                            subcategorys[index]
                                                                .nameEn
                                                                .toString(),
                                                        image:
                                                            subcategorys[index]
                                                                .imageUrl
                                                                .toString(),
                                                      )));
                                        },
                                        child: conected
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 23,
                                                        vertical: 20),
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  elevation: 20.0,
                                                  shadowColor:
                                                      const Color(0xFFF4E55AF),
                                                  child: Container(
                                                    height: 90,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFF7F7F7),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: ListTile(
                                                      // contentPadding: EdgeInsets.zero,
                                                      leading: Container(
                                                        width: 70,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: Colors.black12,
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage(
                                                              subcategorys[
                                                                      index]
                                                                  .imageUrl
                                                                  .toString(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      title: Stack(children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                  ' ${subcategorys[index].nameEn.toString()}')),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 50,
                                                                  left: 5),
                                                          child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                  'category:  ' +
                                                                      widget
                                                                          .categoryname)),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10,
                                                                  left: 100),
                                                          child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text('product: ' +
                                                                  subcategorys[
                                                                          index]
                                                                      .productsCount
                                                                      .toString())),
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Shimmer.fromColors(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 23,
                                                      vertical: 20),
                                                  child: Container(
                                                    height: 90,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFF7F7F7),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                ),
                                              ));
                                  }),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 1, left: 23),
                            child: Text(
                              subcategorys.length.toString() +
                                  '  ' +
                                  'sub categories available',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                      ]);
                    } else {
                      return BildShimmerOffers();
                    }
                  }),
            ),
          ])
        ]));
  }

  ListView BildShimmerOffers() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          // Color _iconColor = Colors.blue;
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          );
        });
  }
}
