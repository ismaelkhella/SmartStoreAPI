import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsstors/Auth/forget_password.dart';
import 'package:smartsstors/Auth/login.dart';
import 'package:smartsstors/Auth/regester.dart';
import 'package:smartsstors/Home/categoryscreen.dart';
import 'package:smartsstors/Home/latestscreen.dart';
import 'package:smartsstors/Home/offerscreen.dart';
import 'package:smartsstors/controller_Db/dbcontrollernew.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';
import 'package:smartsstors/screens/outbording.dart';
import 'package:smartsstors/screens/pagesview.dart';
import 'Auth/launch_screen.dart';
import 'Auth/test5.dart';
import 'Home/carts_creen.dart';
import 'Home/home.dart';
import 'controller_Db/contact_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbControllerproduct().initDataBase();
  await SharedPrefController().initPref();
  runApp(const MyAppShoping());
}

class MyAppShoping extends StatelessWidget {
  const MyAppShoping({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ContactProvider>(
            create: (context) => ContactProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          final mediaQueryData = MediaQuery.of(context);

          return MediaQuery(
              data: mediaQueryData.copyWith(textScaleFactor: 1.0),
              child: child!);
        },
        initialRoute: '/launch_screen',
        routes: {
          '/outBoardingView_screens': (context) => const outpordingview(),
          '/login_screen': (context) => const LoginScreen(),
          '/register_screen': (context) => const RegesterScreen(),
          '/forget_screen': (context) => const ForgetPassword(),
          '/home_screen': (context) => HomePage(),
          '/homes_screen': (context) => CategoryScreen(),
          '/launch_screen': (context) => LaunchScreen(),
          '/test3': (context) => MyHomePage22(
                phon: '',
                password: '',
              ),
          '/latest_screen': (context) => LatestScreen(),
          '/pageView_scree ': (context) => const pageviewe(),
          '/cart_screen': (context) => CartScreen(),
          '/offers_screen': (context) => OffersScreen(),
          '/category_screen': (context) => CategoryScreen(),
        });
  }
}
