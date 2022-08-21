import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:random_string/random_string.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartsstors/Auth/listcity.dart';
import 'package:smartsstors/Home/subcategory.dart';
import 'package:smartsstors/api/auth_api_controller.dart';
import 'package:smartsstors/model/category.dart';
import 'package:smartsstors/model/categoryhome.dart';
import 'package:smartsstors/model/famous_products_home.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';
import 'package:smartsstors/widget/AppTextFieldSearch.dart';
import 'package:smartsstors/widget/app_text_field%20Name.dart';

class CategoryScreen extends StatefulWidget {

  CategoryScreen({Key? key,})
      : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late bool conected;
  List<Category> category = <Category>[];
  late Future<List<Category>> _future1;
  late List<int>idproduct=<int>[];
  List<famous_products> famous = <famous_products>[];
  void initState() {
    //   // TODO: implement initState
    super.initState();
    _future1 = AuthApiController().getCategories();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Color(0xFFF7F7F7),
     body:
     ListView(
       shrinkWrap: true,
       children:[
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
               hintText: 'Search categories ',
               prefixIcon: Icon(Icons.search),
               color: Colors.white),
         ),
         Container(
             margin: EdgeInsets.only(top: 250,bottom: 5),
       child:FutureBuilder<List<Category>>(
          future: _future1,
          builder: (context, snapshot) {
            category = snapshot.data ?? [];
            print(category.length);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildShimmerCategory();
            } else if (snapshot.hasData &&
                snapshot.data!.isNotEmpty) {
              print('8888888888888888888888888888');
              return Stack(
                children:[ Padding(
                  padding: EdgeInsets.only(top: 35,left: 20,right: 20),
            child:Material(
            borderRadius: BorderRadius.circular(15),
            elevation: 20.0,
            shadowColor: Colors.white,

            child: Container(
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomLeft: Radius.circular(20)),
            ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: GridView.builder(
                        itemCount: category.length,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 120,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          return
                            InkWell(
                              onTap: (){
                                Navigator.push
                                  (context,MaterialPageRoute(builder: (context)=>SubCategoryScreen(id: category[index].id, image: category[index].imageUrl, categoryname: category[index].nameEn,)));


                              print('categore' + category[index].id.toString());
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ListCiyty(id: idproduct, idcategory: category[index].id!,)));
                              },
                              child: Stack(children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF7F7F7),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Color(0xFFF7F7F7),
                                      )),
                                  child:conected
                                      ?
                                  ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      category[index]
                                                          .imageUrl
                                                          .toString())))))
                                      : Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child:  Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Container(
                                        width: 200,
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(15),
                                              border: Border.all(
                                                color: Color(0xFFF7F7F7),
                                              )),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: Container(
                                              margin: EdgeInsets.only(left:20,right: 20),
                                              height: 70,
                                              width: 100,
                                              color: Colors.grey,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                conected
                                    ? Padding(
                                    padding:
                                    EdgeInsets.only(top: 70, left: 25),
                                    child: Text(
                                        category[index].nameEn.toString()),)
                                    : Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child:  Padding(
                                      padding: EdgeInsets.only(top: 95, left: 30),
                                      child: Container(
                                        height: 10,
                                        width: 80,
                                        color: Colors.grey,
                                      )),
                                ),
                           ]),
                            );
                        }),
                  ),
                ))),
                  Padding(
                      padding: EdgeInsets.only(left: 23),
                      child: Text(category.length.toString()+'  '+'categories available',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
              ]);
            } else {
              return buildShimmerCategory();
            }
          }),

    )]),

   ]),
     );

  }

  Shimmer buildShimmerCategory() {
    return Shimmer.fromColors(
                   baseColor: Colors.grey[300]!,
                   highlightColor: Colors.grey[100]!,
                   child: Padding(
                     padding: EdgeInsets.symmetric(horizontal: 20),
                     child: GridView.builder(
                         itemCount:10,
                         scrollDirection: Axis.vertical,
                         physics: NeverScrollableScrollPhysics(),
                         shrinkWrap: true,
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 2,
                           crossAxisSpacing: 100,
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
                           margin: EdgeInsets.only(left:20,right: 20),
                                       height: 70,
                                       width: 70,
                                       color: Colors.grey,
                                     ),
                                   )),

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
                 );
  }
}