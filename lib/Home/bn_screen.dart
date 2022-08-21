import 'package:flutter/material.dart';
import 'package:smartsstors/Auth/login.dart';
import 'package:smartsstors/Auth/test2.dart';
import 'package:smartsstors/Auth/test5.dart';
import 'package:smartsstors/Home/categoryscreen.dart';
import 'package:smartsstors/Home/productsubcategory.dart';
import 'package:smartsstors/model/bn_item.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';

import 'editprofile.dart';
import 'favoritscreen.dart';

class BnScreen extends StatefulWidget {
  const BnScreen(
      {Key? key,
      required this.password,
      required this.phon,
      required this.currentindex})
      : super(key: key);
  final String password;
  final String phon;
  final int currentindex;

  @override
  _BnScreenState createState() => _BnScreenState();
}

class _BnScreenState extends State<BnScreen> {
  late int currntstate = widget.currentindex;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Bnitem> _bnitem = <Bnitem>[
    Bnitem(
        title: 'home',
        widget: MyHomePage22(
          phon: SharedPrefController().phon,
          password: SharedPrefController().password,
        )),
    Bnitem(
      title: 'Favourite',
      widget: FavoriatScreen(),
    ),
    Bnitem(title: 'Category', widget: CategoryScreen()),
    Bnitem(title: 'Profile', widget: EditProfile()),
  ];

  @override
  Widget build(BuildContext context) {
    bool genderimagemale;
    if (SharedPrefController().gender == 'M') {
      genderimagemale = true;
    } else {
      genderimagemale = false;
    }
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            //     FutureBuilder<UserStore?>(
            // future: FuturetoObjectuser,
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting && f=='wwww') {
            //         return Center(child: CircularProgressIndicator());
            //       } else if (snapshot.hasData) {
            //       snapshot.data!;
            //       UserObjcttomenu.add(snapshot.data!);
            //       print(SharedPrefController().loggedIn.toString());
            //       f='ttt';
            UserAccountsDrawerHeader(
              accountName: Text(SharedPrefController().name),
              accountEmail: Text(SharedPrefController().phon),
              currentAccountPicture: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: genderimagemale
                            ? NetworkImage(
                                'https://cdn.pixabay.com/photo/2017/04/01/21/06/portrait-2194457_960_720.jpg')
                            : NetworkImage(
                                'https://cdn.pixabay.com/photo/2018/01/29/17/01/woman-3116587_960_720.jpg'),
                      ))),

              //CircleAvatar(
              //   child: Align(
              //     alignment: Alignment.bottomRight,
              //     child: CircleAvatar(
              //       backgroundColor: Colors.grey,
              //       radius: 12.0,
              //       child: Icon(
              //         Icons.camera_alt,
              //         size: 15.0,
              //         color: Color(0xFF404040),
              //       ),
              //     ),
              //   ),
              //   radius: 38.0,
              //   backgroundImage: AssetImage('images/profile.png'),
              // ),
              decoration: BoxDecoration(
                color: Color(0xFFF4E55AF),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2013/07/12/19/04/basket-154317_960_720.png')),
              ),
            ),

            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Friends'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Request'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Policies'),
              onTap: () => null,
            ),
            Divider(),
            ListTile(
                title: Text('Exit'),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  SharedPrefController().clear();
                  Navigator.pushNamed(context, '/loginscreen');
                }),
          ],
        ),
      ),
      appBar: AppBar(
          leadingWidth: 110,
          backgroundColor: Color(0xFFF4E55AF),
          title: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(_bnitem[currntstate].title),
              ),
          leading: Row(children: [
            Padding(
              padding: EdgeInsets.only(top: 10, right: 5, left: 5),
              child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5,bottom: 5),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white,
                    )),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset('images/Logo.png')),
              ),
            ),
          ]),
          elevation: 0,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 16),
                child:
                IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/cartscreen');
                  },
                icon:Icon(Icons.shopping_cart))),
            Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.notifications)),
          ]),
      backgroundColor: Colors.white,
      body: _bnitem[currntstate].widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value) {
          setState(() {
            currntstate = value;
          });
        },
        //type: BottomNavigationBarType.shifting,
        type: BottomNavigationBarType.fixed,
        currentIndex: currntstate,
        // fixedColor: Colors.pink,
        selectedItemColor: Color(0xFFF4E55AF),
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Color(0xFFF4E55AF)),
        selectedLabelStyle: TextStyle(color: Color(0xFFF4E55AF)),
        //بس هاض بغيرش عالكلر غير مرة بدون الاساسيات
        selectedFontSize: 14,
        unselectedItemColor: Colors.grey.shade400,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        unselectedFontSize: 12,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        iconSize: 20,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'home',
              backgroundColor: Colors.black,
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'favorait',
              backgroundColor: Colors.pink),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
              ),
              label: 'category',
              backgroundColor: Colors.cyan),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'profail',
              backgroundColor: Colors.deepPurple),
        ],
      ),
    );
  }
}
