import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartsstors/Auth/listcity.dart';
import 'package:smartsstors/Auth/sheet_code_activation.dart';
import 'package:smartsstors/Home/bn_screen.dart';
import 'package:smartsstors/Home/home.dart';
import 'package:smartsstors/api/apiAuth_test.dart';
import 'package:smartsstors/api/api_settings.dart';
import 'package:smartsstors/api/auth_api_controller.dart';
import 'package:smartsstors/model/categoryhome.dart';
import 'package:smartsstors/model/data.dart';
import 'package:smartsstors/model/famous_products_home.dart';
import 'package:smartsstors/model/latestprouducthome.dart';
import 'package:smartsstors/model/offer.dart';
import 'package:smartsstors/model/slider.dart';
import 'package:smartsstors/model/sliderss.dart';
import 'package:smartsstors/model/userstore.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';
import 'package:smartsstors/screens/pointclider.dart';
import 'package:smartsstors/widget/app_text_field Name.dart';
import 'package:smartsstors/widget/app_text_field Password.dart';
import 'package:smartsstors/widget/food_list_view.dart';
import 'package:smartsstors/widget/food_page_view.dart';

class MyHomePage2 extends StatefulWidget {
  final String password;
  final String phon;

  MyHomePage2({Key? key, required this.password, required this.phon})
      : super(key: key);

  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> with Sheetcodeactivation {
  List<Categories> category = <Categories>[];
  List<Categories> category2 = <Categories>[];
  List<slidersee> _users = <slidersee>[];
  List<Offers> offers = <Offers>[];
  late Future<List<Offers>> _futureOffer;
  Color _iconColor = Colors.red;
  List<Data> MainHome = <Data>[];
  late Future<Data?> _futureHome;
  List<famous_products> famousproduct = <famous_products>[];
  List<LatestProducts> latestprouduct = <LatestProducts>[];
  // late Future<Data> _future;
  late Future<List<Categories>> _future;
  late Future<List<slidersee>> _future1;
  late Future<List<LatestProducts>> _future2;
  late Future<List<famous_products>> _future3;
  List<UserStore> UserObjcttomenu = <UserStore>[];
  List<IconButton>IconsButtons=<IconButton>[];
  List<int>subctegoryid=<int>[];
  late Future<UserStore?> FuturetoObjectuser;
  late String f = 'wwww';
  late bool conected;

  // @override
  void initState() {
    //   // TODO: implement initState
    super.initState();
    _futureHome=AuthApiController().getMainhome(context);
    // _future1 = AuthApiController().getSlider(context);
    // _future = AuthApiController().getCategorias();
    // _future2 = AuthApiController().getlatestprouduct();
    // _future3 = AuthApiController().getfamuosproduct();
    _futureOffer = AuthApiController().getOffers();

  }

  static final DateTime now = DateTime.now();
  String date = now.year.toString() +
      '-' +
      now.month.toString() +
      '-' +
      now.day.toString();
  int _courntpageindex = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(shrinkWrap: true, children: [
              Stack(children: [
                Container(
                  height: 250,
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
                  padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: AppTextField(
                      hintText: 'Search Product offers ',
                      prefixIcon: Icon(Icons.search),
                      color: Colors.white),
                ),

        FutureBuilder<List<slidersee>>(
            future:_future1 ,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildShimmer();
              } else if (snapshot.hasData) {
                _users = snapshot.data ?? [];
                return Padding(
                    padding: EdgeInsets.only(top: 150, right: 40, left: 40),
                    child: Material(
                        borderRadius: BorderRadius.circular(15),
                        elevation: 20.0,
                        shadowColor: Color(0xFFF4E55AF),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CarouselSlider.builder(
                                itemCount: 5,
                                options: CarouselOptions(
                                  onPageChanged: (index, value) {
                                    setState(() {
                                      _courntpageindex = index;
                                    });
                                  },
                                  //enlargeCenterPage: true,
                                  height: 200,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 3),
                                  reverse: false,
                                  aspectRatio: 5.0,
                                  viewportFraction: 1.0,
                                  //       aspectRatio: 2,
                                ),
                                itemBuilder: (context, i, id) {
                                  return GestureDetector(
                                    //ClipRRect for image border radius
                                    child: conected
                                        ? Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            color: Colors.black12,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  _users[i].imageUrl),
                                            )))
                                        : buildShimmer(),
                                  );
                                }))));
              } else {
                return buildShimmer();
              }
            }),

                Container(
                  margin: EdgeInsets.only(top: 300, left: 50),
                  height: 8,
                  child: GridView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 3,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color:
                          _courntpageindex == index ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 170, left: 260),
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text('Day:\n' + date)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 170, left: 60),
                  child: Text(
                    'Latest products\nin our store...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 425, left: 40, right: 10),
                  height: 250,
          child: FutureBuilder<List<Categories>>(
              future:_future ,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return buildShimmerCategory();
                } else if (snapshot.hasData&&snapshot.data!.isNotEmpty) {
                  category=snapshot.data??[];
                  return GridView.builder(
                            itemCount: 4,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 130,
                                mainAxisSpacing: 20),
                            itemBuilder: (context, index) {
                              return Stack(children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF7F7F7),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Color(0xFFF7F7F7),
                                      )),
                                  child:

                                  conected
                                      ?
                                  ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                              color: Colors.black12,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      category[index].imageUrl
                                                          .toString())))))
                                      : Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          color: Colors.grey,
                                        )),
                                  ),
                                ),
                                conected
                                    ? Padding(
                                    padding:
                                    EdgeInsets.only(top: 70, left: 25),
                                    child: Text(
                                        category[index].nameEn.toString()))
                                    : Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 85, left: 10),
                                      child: Container(
                                        height: 10,
                                        width: 80,
                                        color: Colors.grey,
                                      )),
                                ),
                              ]);
                            });}else{return buildShimmerCategory();}}),
        ),

                Padding(
                    padding: EdgeInsets.only(top: 660, left: 40),
                    child: Row(
                      children: [
                        Text(
                          'latest_products',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 150),
                          child: Text(
                            'see more',
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ),
                        IconButton(onPressed: () {
                          Navigator.pushNamed(context, '/latest_screen');
                        }, icon: Icon(Icons.arrow_forward_ios, size: 15,),
                        )
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(top: 705),
                  height: 300,
          child: FutureBuilder<List<LatestProducts>>(
              future:_future2 ,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return buildShimmerlastestproduct();
                } else if (snapshot.hasData) {
                  latestprouduct=snapshot.data??[];
                  return GridView.builder(
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 20,
                              childAspectRatio: 8 / 6,
                            ),
                            itemBuilder: (context, index) {
                              // subctegoryid.add(latestprouduct[index]
                              //     .subCategoryId!);
                              return InkWell(
                                onTap: () {},
                                child: Stack(children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    height: 300,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF7F7F7),
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(
                                          color: Color(0xFFF7F7F7),
                                        )),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.only(bottom: 150),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(24)),
                                        child: conected
                                            ? ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(24),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  24),
                                              color: Colors.black12,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  latestprouduct[index].imageUrl
                                                      .toString(),
                                                ),
                                              ),

                                            ),
                                          ),)
                                            : Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            height: 205,
                                            width: 180,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                              BorderRadius.circular(24),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  conected
                                      ? Stack(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: 170, left: 6),
                                          child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  latestprouduct[index].nameEn!))),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 170, right: 6),
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text(latestprouduct[index].price
                                                .toString() + '₪')),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: 215, left: 6),
                                          child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text('Quantity'))),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 215, right: 6),
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                                latestprouduct[index].quantity
                                                    .toString())),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 240, left: 6),
                                        child: Row(
                                            children: [
                                              Text('add to cart'),
                                              Padding(
                                                padding: EdgeInsets.only(left: 20),
                                                child: InkWell(
                                                    onTap: () {
                                                      if (index == 0) {}
                                                    },
                                                    child: IconButton(icon: Icon(
                                                        Icons.shopping_cart),
                                                        onPressed: () {})),),

                                            ]),
                                      ),
                                    ],
                                  )
                                      : Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Stack(
                                        children: [ Padding(
                                          padding: EdgeInsets.only(
                                              top: 170, left: 10),
                                          child: Container(
                                            height: 20,
                                            width: 180,
                                            color: Colors.grey,
                                          ),
                                        ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 200, left: 10),
                                            child: Container(
                                              height: 20,
                                              width: 180,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 240, left: 10),
                                            child: Container(
                                              height: 20,
                                              width: 180,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ]),
                              );
                            });}else{return buildShimmerlastestproduct();}
                  }),
        ),
                Padding(
                    padding: EdgeInsets.only(top: 370, left: 40),
                    child: Row(
                      children: [
                        Text(
                          'Category',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 190),
                          child: Text(
                            'see more',
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ),
                        IconButton(onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => BnScreen(currentindex: 2,
                                  password: SharedPrefController().password,
                                  phon: SharedPrefController().phon)));
                        }, icon: Icon(Icons.arrow_forward_ios, size: 15,),
                        )
                      ],
                    )), Padding(
                    padding: EdgeInsets.only(top: 1550, left: 40),
                    child: Row(
                      children: [
                        Text(
                          'offers_product',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 155),
                          child: Text(
                            'see more',
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ),
                        IconButton(onPressed: () {
                          Navigator.pushNamed(context, '/offers_screen');
                        }, icon: Icon(Icons.arrow_forward_ios, size: 15,),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 980), child: Text('')),
                Padding(
                    padding: EdgeInsets.only(top: 1030, left: 40),
                    child: Text(
                      'famous_products',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 1030, left: 300),
                  child: Row(
                    children: [
                      Text(
                        'see more',
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 1070),
          child: FutureBuilder<List<famous_products>>(
              future:_future3 ,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return buildShimmerfamous();
                } else if (snapshot.hasData) {
                  famousproduct=snapshot.data ??[];
                  return InkWell(
                          child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 4,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 90,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 3 / 7),
                              itemBuilder: (context, index) {
                                // Color _iconColor = Colors.blue;
                                return Stack(children: [
                                  Container(
                                    height: 300,
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF7F7F7),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child:
                                    conected
                                        ? ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      child: Stack(
                                          children: [Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  15),
                                              color: Colors.black12,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  famousproduct[index].imageUrl
                                                      .toString(),
                                                ),
                                              ),


                                            ),
                                          )
                                          ]),
                                    ) : Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor:
                                      Colors.grey[100]!,
                                      child: Container(
                                        height: 700,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(
                                                24)),
                                        child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(
                                                15),
                                            child: Padding(
                                              padding: EdgeInsets.only(bottom: 40),
                                              child: Container(
                                                color: Colors.grey,
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                  conected
                                      ? Stack(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: 170, left: 6),
                                          child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  famousproduct[index].nameEn!))),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 170, right: 6),
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text(famousproduct[index].price
                                                .toString() + '₪')),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: 215, left: 6),
                                          child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text('Quantity'))),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 215, right: 6),
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                                famousproduct[index].quantity
                                                    .toString())),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 240, left: 6),
                                        child: Row(
                                            children: [
                                              Text('add to cart'),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20),
                                                  child: IconButton(icon: Icon(
                                                    Icons.shopping_cart,
                                                    color: _iconColor,),
                                                      onPressed: () {
                                                        setState(() {
                                                          _iconColor =
                                                          _iconColor == Colors.red
                                                              ? Colors.yellow
                                                              : Colors.red;
                                                        });
                                                      })),

                                            ]),
                                      ),
                                    ],
                                  )
                                      : Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 320, left: 10),
                                      child: Container(
                                        height: 20,
                                        width: 90,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ]);
                              }

                          ),
                        );}else{return buildShimmerfamous();}}),
        ),

                Container(
                    margin: EdgeInsets.only(top: 1600),
                    child: FutureBuilder<List<Offers>>(
                        future: _futureOffer,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState
                              .waiting) {
                            return BildShimmerOffers();
                          } else if (snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            offers = snapshot.data ?? [];
                            return InkWell(
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 3,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    // Color _iconColor = Colors.blue;
                                    return conected ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 23, vertical: 20),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(15),
                                        elevation: 20.0,
                                        shadowColor: Color(0xFFF4E55AF),
                                        child: Container(
                                          height: 90,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF7F7F7),
                                            borderRadius: BorderRadius.circular(
                                                15),
                                          ),
                                          child: ListTile(
                                            // contentPadding: EdgeInsets.zero,
                                            leading: Container(
                                              width: 70,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(15),
                                                color: Colors.black12,
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    offers[index].imageUrl
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
                                            ),
                                            title: Stack(
                                                children: [ Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10),
                                                  child: Align(
                                                      alignment: Alignment
                                                          .topLeft,
                                                      child: Text(
                                                          ' ${offers[index]
                                                              .nameEn
                                                              .toString()}')),
                                                ),

                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 50),
                                                    child: Align(
                                                        alignment: Alignment
                                                            .topLeft,
                                                        child: Text('${' ' +
                                                            'discount:' + ' ' +
                                                            offers[index]
                                                                .discountPrice
                                                                .toString()}')),
                                                  ),
                                                  Container(
                                                      width: 100,
                                                      margin: EdgeInsets.only(
                                                          top: 53, left: 120),
                                                      child: Divider(
                                                        color: Colors.red,)),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 50, left: 120),
                                                    child: Align(
                                                        alignment: Alignment
                                                            .topLeft,
                                                        child: Text(
                                                            ' ${'original:' +
                                                                ' ' +
                                                                offers[index]
                                                                    .originalPrice
                                                                    .toString()}')),
                                                  ),
                                                ]),
                                          ),
                                        ),

                                      ),
                                    ) : Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 23, vertical: 20),
                                        child: Container(
                                          height: 90,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF7F7F7),
                                            borderRadius: BorderRadius.circular(
                                                15),
                                          ),
                                        ),
                                      ),
                                    );
                                  }


                              ),
                            );
                          } else {
                            return BildShimmerOffers();
                          }
                        })),
              ]),
            ]));
  }

  GridView buildShimmerfamous() {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 130,
            mainAxisSpacing: 20,
            childAspectRatio: 4 / 7),
        itemBuilder: (context, index) {
          return Stack(children: [
            Container(
                height: 400,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 40),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 700,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              color: Colors.grey,
                            )),
                      ),
                    ),
                  ),
                )),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Padding(
                padding: EdgeInsets.only(top: 200, left: 10),
                child: Container(
                  height: 20,
                  width: 90,
                  color: Colors.grey,
                ),
              ),
            ),
          ]);
        });
  }

  GridView buildShimmerlastestproduct() {
    return GridView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 20,
          childAspectRatio: 7/4,
        ),
        itemBuilder: (context, index) {
          return Stack(children: [
            Container(
              padding: EdgeInsets.all(4),
              height: 300,
              decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color(0xFFF7F7F7),
                  )),
              child: Padding(
                padding: EdgeInsets.only(top: 40, bottom: 40),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 205,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Padding(
                padding: EdgeInsets.only(top: 270, left: 10),
                child: Container(
                  height: 20,
                  width: 90,
                  color: Colors.grey,
                ),
              ),
            ),
          ]);
        });
  }

  Shimmer buildShimmerCategory() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 130,
          ),
          itemBuilder: (context, index) {
            return Stack(children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Color(0xFFF7F7F7),
                    )),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 70,
                      width: 70,
                      color: Colors.grey,
                    )),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 85, left: 10),
                  child: Container(
                    height: 10,
                    width: 80,
                    color: Colors.grey,
                  )),
            ]);
          }),
    );
  }

  Shimmer buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CarouselSlider.builder(
            itemCount: _users.length,
            options: CarouselOptions(
              onPageChanged: (index, value) {
                setState(() {
                  _courntpageindex = index;
                });
              },
              //enlargeCenterPage: true,
              height: 200,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              reverse: false,
              aspectRatio: 5.0,
              viewportFraction: 1.0,
              //       aspectRatio: 2,
            ),
            itemBuilder: (context, i, id) {
              return GestureDetector(
                  //ClipRRect for image border radius
                  child: Container(
                width: 360,
                height: 100,
                color: Colors.grey,
              ));
            }),
      ),
    );
  }

  Stack Bildshimmerall() {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CarouselSlider.builder(
                itemCount: _users.length,
                options: CarouselOptions(
                  onPageChanged: (index, value) {
                    setState(() {
                      _courntpageindex = index;
                    });
                  },
                  //enlargeCenterPage: true,
                  height: 200,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  reverse: false,
                  aspectRatio: 5.0,
                  viewportFraction: 1.0,
                  //       aspectRatio: 2,
                ),
                itemBuilder: (context, i, id) {
                  return GestureDetector(
                      //ClipRRect for image border radius
                      child: Container(
                    width: 360,
                    height: 100,
                    color: Colors.grey,
                  ));
                }),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: GridView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 130,
              ),
              itemBuilder: (context, index) {
                return Stack(children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Color(0xFFF7F7F7),
                        )),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 70,
                          width: 70,
                          color: Colors.grey,
                        )),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 85, left: 10),
                      child: Container(
                        height: 10,
                        width: 80,
                        color: Colors.grey,
                      )),
                ]);
              }),
        ),
        GridView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 20,
              childAspectRatio: 7 / 4,
            ),
            itemBuilder: (context, index) {
              return Stack(children: [
                Container(
                  padding: EdgeInsets.all(4),
                  height: 300,
                  decoration: BoxDecoration(
                      color: Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Color(0xFFF7F7F7),
                      )),
                  child: Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 40),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24)),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 205,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Padding(
                    padding: EdgeInsets.only(top: 270, left: 10),
                    child: Container(
                      height: 20,
                      width: 90,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ]);
            }),
        GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 130,
                mainAxisSpacing: 20,
                childAspectRatio: 4 / 7),
            itemBuilder: (context, index) {
              return Stack(children: [
                Container(
                    height: 400,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 40),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24)),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 700,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                      ),
                    )),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Padding(
                    padding: EdgeInsets.only(top: 200, left: 10),
                    child: Container(
                      height: 20,
                      width: 90,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ]);
            }),
      ],
    );
  }
  ListView BildShimmerOffers(){
    return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
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
