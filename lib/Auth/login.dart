import 'package:flutter/material.dart';
import 'package:smartsstors/Auth/helpers.dart';
import 'package:smartsstors/Home/bn_screen.dart';
import 'package:smartsstors/api/auth_api_controller.dart';
import 'package:smartsstors/widget/app_text_field Name.dart';
import 'package:smartsstors/widget/app_text_field Password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  bool _obscureText = true;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _landScape = MediaQuery.of(context).size.height;
    double _portrait = MediaQuery.of(context).size.width;
    double landScape = _landScape;
    double portrait = _portrait;

    //
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding:
            EdgeInsets.symmetric(horizontal: 20, vertical: landScape * 0.06),
        children: [
          Image(
            image: AssetImage('images/Logo.png'),
            height: landScape * 0.064,
            width: portrait * 0.0138,
          ),
          Padding(
            padding: EdgeInsets.only(top: landScape * 0.017),
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                width: portrait * 0.89,
                // color: Colors.red,
                height: landScape * 0.57,
              ),
              Padding(
                padding: EdgeInsets.only(top: landScape * 0.078, left: 10),
                child: Text(
                  'Sign in ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: landScape * 0.11, left: 10),
                child: const Text(
                  'to continue',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding:
                    EdgeInsets.only(top: landScape * 0.20, left: 10, right: 10),
                child: AppTextField(
                  hintText: 'Name',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color(0xFF222B45),
                  ),
                  color: Color(0xFFF7F7F7),
                  controller: _emailTextController,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(
                    top: landScape * 0.293, left: 10, right: 10),
                child: AppTextFieldP(
                    controller: _passwordTextController,
                    obscureText: _obscureText,
                    hintText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xFF222B45),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                    )),
              ),
              const SizedBox(height: 15),
              Container(
                child:Padding(
                  padding: EdgeInsets.only(
                      top: landScape * 0.428, left: 10, right: 10),
                  child: Container(
                    width: portrait * 0.893,
                    height: landScape * 0.068,
                    decoration: BoxDecoration(
                      color: Color(0xFF4E55AF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        await _performRegister();
                      },
                      child: Text('login',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have an account'),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/register_screen'),
                child: const Text('Create Now!'),
              ),
            ],
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/forget_screen'),
            child: const Text('Forget Password?'),
          ),
        ],
      ),
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
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
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
    bool statas = await AuthApiController().Login(context,
        mobile: _emailTextController.text,
        passwor: _passwordTextController.text);
    if (statas) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BnScreen( password: _passwordTextController.text, phon:_emailTextController.text, currentindex: 0,)));

    }
  }
}
