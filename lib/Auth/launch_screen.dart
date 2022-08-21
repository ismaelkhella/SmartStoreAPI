import 'package:flutter/material.dart';
import 'package:smartsstors/Home/bn_screen.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';

class LaunchScreen extends StatefulWidget {
  LaunchScreen({Key? key}) : super(key: key);
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      print(SharedPrefController().phon);
      SharedPrefController().loggedIn
          ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BnScreen( password:SharedPrefController().password , phon:SharedPrefController().phon, currentindex: 0,)))
      : Navigator.pushReplacementNamed(context,'/login_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(

          gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade100,
            ],
          ),
        ),
        child: const Text(
          'Smart Store',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
