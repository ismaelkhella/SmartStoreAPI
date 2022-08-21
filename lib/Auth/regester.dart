import 'package:flutter/material.dart';
import 'package:smartsstors/Auth/activate_code.dart';
import 'package:smartsstors/widget/app_text_field Name.dart';
import 'package:smartsstors/widget/app_text_field Password.dart';
import 'package:smartsstors/Auth/helpers.dart';
import 'package:smartsstors/api/auth_api_controller.dart';
import 'package:smartsstors/model/cities.dart';
import 'package:smartsstors/model/userstore.dart';


class RegesterScreen extends StatefulWidget {
  const RegesterScreen({Key? key}) : super(key: key);

  @override
  _RegesterScreenState createState() => _RegesterScreenState();
}

class _RegesterScreenState extends State<RegesterScreen> with Helpers {
  late TextEditingController _fullNAmeTextController;
  late TextEditingController _phoneTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _cityIDController;
  String _gender = 'M';
  int? selectedCity;
  bool _obscureText=true;
  List<cities> Cities = <cities>[];
  late Future<List<cities>> _city;

  @override
  void initState() {
    //   // TODO: implement initState
    super.initState();
    _fullNAmeTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _cityIDController = TextEditingController();
    _city = AuthApiController().getCities(context);
  }

  @override
  void dispose() {
    //   // TODO: implement dispose
    _fullNAmeTextController.dispose();
    _phoneTextController.dispose();
    _passwordTextController.dispose();
    _cityIDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _landScape = MediaQuery.of(context).size.height;
    double _portrait = MediaQuery.of(context).size.width;
    double landScape = _landScape;
    double portrait = _portrait;
    print(landScape);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding:
            EdgeInsets.symmetric(horizontal: 20, vertical: landScape * 0.069),
        children: [
          Image(
            image: const AssetImage('images/Logo.png'),
            height: landScape * 0.0594,
            width: portrait * 0.0138,
          ),
          Padding(
            padding: EdgeInsets.only(top: landScape * 0.0274),
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                width: portrait * 0.89,
                // color: Colors.red,
                height: landScape * 0.72,
              ),
              Padding(
                padding: EdgeInsets.only(top: landScape * 0.0457, left: 10),
                child: const Text(
                  'Create new',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: landScape * 0.0957, left: 10),
                child: const Text(
                  'Account.',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: landScape * 0.164, left: 10, right: 10),
                child: AppTextField(
                  hintText: 'Name',
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color(0xFF222B45),
                  ),
                  color: const Color(0xFFF7F7F7),
                  controller: _fullNAmeTextController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: landScape * 0.256, left: 10, right: 10),
                child: AppTextField(
                  hintText: '587691611',
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Color(0xFF222B45),
                  ),
                  color: const Color(0xFFF7F7F7),
                  controller: _phoneTextController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: landScape * 0.348, left: 10, right: 10),
                child: AppTextFieldP(
                    obscureText: _obscureText,
                    hintText: 'password',
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color(0xFF222B45),
                    ),
                    controller: _passwordTextController,
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
              Container(
                width: portrait * 0.893,
                height: landScape * 0.064,
                decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(16)),
                margin:
                    EdgeInsets.only(top: landScape * 0.44, left: 10, right: 10),
                child: Padding(
                  padding: EdgeInsets.only(left: portrait * 0.12),
                  child: FutureBuilder<List<cities>>(
                      future: _city,
                      builder: (context, snapshot) {
                        Cities = snapshot.data ?? [];
                        return DropdownButton<int>(
                          // Initial Value
                          hint:Text(Cities.length.toString()),
                          isExpanded: true,
                          onTap: () {},
                          elevation: 4,
                          value: selectedCity,
                          onChanged: (int? value) {
                            if (value != null) {
                              setState(() {
                                selectedCity = value;
                                print(selectedCity);
                              });
                            }
                          },
                          items:Cities.map((e)=>
                             DropdownMenuItem(
                                  child: Text(e.nameEn),
                                  value: e.id,
                                ),
                              )
                              .toList(),
                        );}),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: landScape * 0.46, left: portrait * 0.05),
                child: const Icon(
                  Icons.location_city,
                  color: Color(0xFF222B45),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: landScape * 0.534),
                child: Row(children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Female'),
                      groupValue: _gender,
                      value: 'F',
                      onChanged: (String? value) {
                        if (value != null) {
                          setState(() {
                            _gender = value;
                          });
                        }
                      },
                    ),
                  ),
                  Expanded(
                      child: RadioListTile<String>(
                              title: const Text('Male'),
                    groupValue: _gender,
                    value: 'M',
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _gender = value;
                        });
                      }
                    },
                  ))
                ]),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: landScape * 0.614, left: 10, right: 10),
                  child: Container(
                    width: portrait * 0.893,
                    height: landScape * 0.064,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E55AF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextButton(
                      onPressed: ()async=>_performRegister(), child: const Text('Create',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('I already have an account.'),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/login_screen'),
                child: const Text('Sign in '),
              ),
            ],
          ),
          TextButton(
            onPressed: ()=>Navigator.pushNamed(context, '/forget_screen'),
            child: const Text('Forget Password?'),
          ),
        ],
      ),
    );
  }

  Future<bool> _performRegister() async {
    if (_checkData()) {
      _Login();
      return true;
    } else {
      return false;
    }
  }

  bool _checkData() {
    if (_fullNAmeTextController.text.isNotEmpty &&
        _phoneTextController.text.isNotEmpty &&
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

  Future<void> _Login() async {
    bool statas =
        await AuthApiController().register(context, userStore: userstores);
    if (statas) {
      Future.delayed(const Duration(seconds: 5), () {
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ActivationCode(mobile: _phoneTextController.text,)));
    });
  }}

  UserStore get userstores {
    UserStore userstore = UserStore();
    userstore.name = _fullNAmeTextController.text;
    userstore.mobile = _phoneTextController.text;
    userstore.password = _passwordTextController.text;
    userstore.cityId = Cities[selectedCity!-1].id.toString();
    print(userstore.cityId);
    userstore.STORE_API_KEY;
    userstore.gender = _gender;

    return userstore;
  }
}
