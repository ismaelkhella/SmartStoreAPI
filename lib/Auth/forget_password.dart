import 'package:flutter/material.dart';
import 'package:smartsstors/Auth/helpers.dart';
import 'package:smartsstors/Auth/reset_password.dart';
import 'package:smartsstors/api/auth_api_controller.dart';
import 'package:smartsstors/widget/app_text_field Name.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>with Helpers {
  late TextEditingController _phoneTextController;
  bool f=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _landScape = MediaQuery.of(context).size.height;
    double _portrait = MediaQuery.of(context).size.width;
    double textScale = MediaQuery.of(context).textScaleFactor;
    double landScape = _landScape;
    double portrait = _portrait;
    //
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding:
          EdgeInsets.symmetric(horizontal: 20, vertical: landScape * 0.036),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: EdgeInsets.only(right: portrait * 0.042),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Forget password',
                  style: TextStyle(fontSize: 18.0*textScale, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: landScape * 0.017),
              child: Stack(children: [
                Padding(
                  padding: EdgeInsets.only(top: landScape * 0.04, left: 10),
                  child: const Text(
                    'Continue using',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: landScape * 0.095, left: 10),
                  child: const Text(
                    'Enter mobile to receive reset code...',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(
                      top: landScape * 0.188, left: 10, right: 10),
                  child: AppTextField(
                    hintText: 'Name',
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color(0xFF222B45),
                    ),
                    color: Colors.white, controller:_phoneTextController ,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(
                      top: landScape * 0.392, left: 10, right: 10),
                  child: Container(
                    width: portrait * 0.893,
                    height: landScape * 0.068,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E55AF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextButton(
                      onPressed: () async=> await _performRegister(), child: const Text('send'),
                    ),
                  ),
                ),
              ]),
            ),
          ]),
    );
  }


  Future<bool> _performRegister() async {
    if (_checkData()) {
      _activation();
      return true;
    } else {
      return false;
    }
  }

  bool _checkData() {
    if (_phoneTextController.text.isNotEmpty) {
      return true;
    }
    //TODO: SHOW SNACK BAR
    showSnackBar(
      context: context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }

  Future<void> _activation() async {
    bool status =
    await AuthApiController().forgetPassword(context,mobile: _phoneTextController.text);
    if (status) {
      Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ResetPasswordScreen(mobile: _phoneTextController.text)));
    });
  }
  }


  }



