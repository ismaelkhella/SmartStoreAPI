import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:smartsstors/Home/productDescription.dart';
import 'package:smartsstors/Home/productDescriptionnoffer.dart';
import 'package:smartsstors/api/auth_api_controller.dart';
import 'package:smartsstors/model/productsmodel.dart';
import 'package:smartsstors/widget/AppTextFieldSearch.dart';

class ProductSubCategoryScreen extends StatefulWidget {
  ProductSubCategoryScreen(
      {Key? key,
      required this.id,
      required this.image,
      required this.categoryname})
      : super(key: key);
  final int id;
  final String image;
  final String categoryname;

  @override
  _ProductSubCategoryScreenState createState() =>
      _ProductSubCategoryScreenState();
}

class _ProductSubCategoryScreenState extends State<ProductSubCategoryScreen> {
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  late bool conected;
  List<Productsmodel> Productsubcategorys = <Productsmodel>[];
  List<int> subcategorysleangth = <int>[];
  late int offerslegnth;
  double rate = 3;
  Color _iconColor = Colors.red;
  late int leanthsubcategorys = 0;
  late Future<List<Productsmodel>> _futureProductsubcategorys;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    //   // TODO: implement initState
    super.initState();
    _futureProductsubcategorys =
        AuthApiController().getProductDetails(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    double landscape = MediaQuery.of(context).size.height;
    double portrait = MediaQuery.of(context).size.width;
    double Landscape = landscape;
    double Portrait = portrait;
    return RefreshIndicator(
      displacement: 250,
      key: _refreshIndicatorKey,
      backgroundColor: Colors.yellow,
      color: Colors.red,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: _refreshPhotos,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFFF4E55AF),
            leading: Hero(
              tag: 'next2',
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            )),
        body: ListView(shrinkWrap: true, children: [
          Stack(children: [
            Container(
              height: 250,
              color: Color(0xFFF4E55AF),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50, top: 20),
              child: SimpleShadow(
                opacity: 0.6,
                // Default: 0.5
                color: Colors.blue,
                // Default: Black
                offset: Offset(30, 30),
                // Default: Offset(2, 2)
                sigma: 7,
                child: Padding(
                    padding: EdgeInsets.only(left: 50, right: 100),
                    child: Image.network(
                      widget.image.toString(),
                      height: 150,
                    )),
              ),
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
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.white),
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
              padding: EdgeInsets.only(top: 230, left: 40, right: 40),
              child: AppTextFieldSearch(
                  hintText: 'Search Product ',
                  prefixIcon: Icon(Icons.search),
                  color: Colors.white),
            ),
            FutureBuilder<List<Productsmodel>>(
                future: _futureProductsubcategorys,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    Productsubcategorys = snapshot.data ?? [];
                    rate = Productsubcategorys[0].overalRate!.toDouble();
                    return Stack(children: [
                        Container(
                          margin: EdgeInsets.only(top: 400),
                          child: InkWell(
                            child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: Productsubcategorys.length,
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 0,
                                        childAspectRatio: 5 / 9),
                                itemBuilder: (context, index) {
                                  rate = Productsubcategorys[index]
                                      .overalRate!
                                      .toDouble();
                                  // Color _iconColor = Colors.blue;
                                  return conected
                                      ? InkWell(
                                    onTap: () {
                                      if(Productsubcategorys[index].offerPrice==null){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDescriptionsScreen(
                                                    id: Productsubcategorys[index].id!,
                                                    expired: true,
                                                  )));
                                    }else{
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDescriptionsScreenOffer(
                                                      id: Productsubcategorys[index].id!,
                                                      image: Productsubcategorys[index]
                                                          .imageUrl
                                                          .toString(),
                                                    )));
                                      }},
                                        child: Padding(
                                    padding: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                                          child: Container(
                                              height: 600,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                color: Colors.blueGrey.shade100,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(20),
                                                    topRight: Radius.circular(20)),
                                              ),
                                              child: Material(
                                                  borderRadius: BorderRadius.only(
                                                      bottomLeft: Radius.circular(20),
                                                      topRight: Radius.circular(20)),
                                                  elevation: 20.0,
                                                  shadowColor: Color(0xFFF4E55AF),
                                                  child: Stack(children: [
                                                    Container(
                                                      height: 150,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(20),
                                                            bottomLeft:
                                                                Radius.circular(20)),
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                            Productsubcategorys[index]
                                                                .imageUrl
                                                                .toString(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 160, left: 130),
                                                      child: IconButton(
                                                        iconSize: 30,
                                                        onPressed: () async {
                                                          await AuthApiController()
                                                              .favoraite(context,
                                                                  product_id:
                                                                      Productsubcategorys[
                                                                              index]
                                                                          .id);
                                                          setState(() =>
                                                          Productsubcategorys[index]
                                                                      .isFavorite =
                                                                  !Productsubcategorys[
                                                                          index]
                                                                      .isFavorite!);
                                                        },
                                                        icon: Productsubcategorys[index]
                                                                .isFavorite!
                                                            ? Icon(Icons.favorite,
                                                                color: Colors.red)
                                                            : Icon(
                                                                Icons.favorite_border,
                                                                color: Colors.red),
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                            top: 170, left: 20),
                                                        child: Text(
                                                          Productsubcategorys[index].nameEn.toString() ,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        )),
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                            top: 210, left: 20),
                                                        child: Text(
                                                          'Rate the product:',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight.w300),
                                                        )),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 250, left: 20),
                                                      child: RatingBar.builder(
                                                        initialRating: rate,
                                                        minRating: rate,
                                                        maxRating: rate,
                                                        ignoreGestures: true,
                                                        updateOnDrag: true,
                                                        direction: Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemSize: 20,
                                                        // glow: false,
                                                        itemPadding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 4.0),
                                                        itemBuilder: (context, _) =>
                                                            Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate: (rating) {
                                                          setState(() {
                                                            rating = rate;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                            top: 290, left: 20),
                                                        child: Text(
                                                          Productsubcategorys[index]
                                                                  .price
                                                                  .toString() +
                                                              '₪',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        )),
                                                  ])),
                                            ),
                                        ),
                                      )
                                      : Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 20
                                            ),
                                            child: Container(
                                              height: 700,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(24)),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.only(bottom: 40),
                                                    child: Container(
                                                      color: Colors.grey,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        );
                                }),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 350, left: 23),
                            child: Text(
                              Productsubcategorys.length.toString() +
                                  '  ' +
                                  'products available',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                      ]);
                  } else {
                    return CircularProgressIndicator();
                  }
                })
          ])
        ]),
      ),
    );
  }
  Future<void> _refreshPhotos() async {
    final photos = await AuthApiController().getProductDetails(id: widget.id);
    setState(() {
      build(context);
      Productsubcategorys = photos;

    });

  }
  Future<void> _reload(var value) async {
    print(
        'Home Page resumed after popping/closing SecondPage with value {$value}. Do something.');
  }
}
