import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartsstors/api/auth_api_controller.dart';
import 'package:smartsstors/model/categoryhome.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';
import 'package:smartsstors/widget/AppTextFieldSearch.dart';
import 'package:smartsstors/widget/app_text_field%20Name.dart';

class LatestScreen extends StatefulWidget {

  LatestScreen({Key? key})
      : super(key: key);

  @override
  _LatestScreenState createState() => _LatestScreenState();
}

class _LatestScreenState extends State<LatestScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late bool conected;
  @override
  Widget build(BuildContext context) {
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
                  currentAccountPicture: CircleAvatar(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 12.0,
                        child: Icon(
                          Icons.camera_alt,
                          size: 15.0,
                          color: Color(0xFF404040),
                        ),
                      ),
                    ),
                    radius: 38.0,
                    backgroundImage: AssetImage('images/profile.png'),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
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
                    onTap: () { SharedPrefController().clear();
                    Navigator.pushNamed(context,'/loginscreen');

                    }
                ),
              ],
            ),
          ),
          appBar: AppBar(
              leadingWidth: 110,
              backgroundColor: Color(0xFFF4E55AF),
              title: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Home',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
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
                  padding: EdgeInsets.only(top: 10),
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
                    child: Icon(Icons.shopping_cart)),
                Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.notifications)),
              ]),
          backgroundColor: Colors.white,
      body:     ListView(
        shrinkWrap: true,
        children:[ Stack(children: [
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
            hintText: 'Search Product ',
            prefixIcon: Icon(Icons.search),
            color: Colors.white),
      ),


    ])]));

}}