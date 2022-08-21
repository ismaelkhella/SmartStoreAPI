import 'package:flutter/material.dart';
import 'package:smartsstors/Auth/helpers.dart';
import 'package:smartsstors/api/auth_api_controller.dart';
import 'package:smartsstors/model/userstore.dart';
import 'package:smartsstors/widget/app_text_field Name.dart';

class ActivationCode extends StatefulWidget {
  ActivationCode({Key? key,required this.mobile}) : super(key: key);
  final String mobile;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ActivationCode>with Helpers {
  late TextEditingController _activateTextController;
  bool f=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activateTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _activateTextController.dispose();
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
                  'Activation Code',
                  style: TextStyle(fontSize: 18*textScale, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: landScape * 0.017),
              child: Stack(children: [
                Padding(
                  padding: EdgeInsets.only(top: landScape * 0.04, left: 10),
                  child: Text(
                    'Continue using',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24*textScale,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: landScape * 0.095, left: 10),
                  child:  Text(
                    'Activation code.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24*textScale,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(
                      top: landScape * 0.188, left: 10, right: 10),
                  child: AppTextField(
                    hintText: 'Code',
                    prefixIcon: const Icon(
                      Icons.numbers,
                      color: Color(0xFF222B45),
                    ),
                    color: Colors.white, controller:_activateTextController ,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  child: Padding(
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
                ),
              ]),
            ),
          ]),
    );
  }


  Future<bool> _performRegister() async {
    if (checkCode()&&_checkData()) {
      _activation();
      return true;
    } else {
      return false;
    }
  }

  bool _checkData() {
    if (_activateTextController.text.isNotEmpty) {
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
    bool statas =
    await AuthApiController().Activation(context, userstores);
    if (statas) {
      Navigator.pushNamed(context, '/login_screen');
    }
  }
  bool checkCode() {
    if (_activateTextController.text.length != 4) {
      showSnackBar(
        context: context,
        message: 'Enter received code 4 digits yagagsaggs',
        error: true,
      );
    }
    return true;
  }

  UserStore get userstores {
    UserStore userstore = UserStore();
    userstore.mobile = widget.mobile;
    userstore.actives =_activateTextController.text;
    return userstore;
  }
}


