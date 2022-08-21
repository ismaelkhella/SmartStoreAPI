import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartsstors/Auth/activate_code.dart';
import 'package:smartsstors/model/passworedChange.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';
import 'package:smartsstors/widget/app_text_field Name.dart';
import 'package:smartsstors/widget/app_text_field Password.dart';
import 'package:smartsstors/Auth/helpers.dart';
import 'package:smartsstors/api/auth_api_controller.dart';
import 'package:smartsstors/model/cities.dart';
import 'package:smartsstors/model/citys.dart';
import 'package:smartsstors/model/userstore.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with Helpers {
  late TextEditingController _fullNAmeTextController;
  late TextEditingController _NewPasswordTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _confirmPassword;
  String? _gender=SharedPrefController().gender;
  int? selectedcity=SharedPrefController().city as int?;
  bool _obscureText = true;
  bool _obscureTextNew = true;
  bool _obscureTextConfirm = true;
  bool cheakselectedcity=true;
  late String cityt;

  //var List_name=['','',];
  late List<cities> Cities = <cities>[];
  late Future<List<cities>> _city;

  // @override
  void initState() {
    //   // TODO: implement initState
    super.initState();
    //   _emailTextController = TextEditingController();
    //   _passwordTextController = TextEditingController();
    _fullNAmeTextController =
        TextEditingController(text: SharedPrefController().name);
    _NewPasswordTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPassword = TextEditingController();
    _city = AuthApiController().getCities(context);
  }

  //
  // @override
  void dispose() {
    //   // TODO: implement dispose
    _fullNAmeTextController.dispose();
    _NewPasswordTextController.dispose();
    _passwordTextController.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     double landscape = MediaQuery.of(context).size.height;
    double portrait = MediaQuery.of(context).size.width;
    double Landscape = landscape;
    double Portrait = portrait;
     // fcmRandonTokeken= randomString(20);
    print(SharedPrefController().city.toString()+'lolololololo');
    // _phonTextController.text='jamalos';
    bool genderimagemale;
    print(landscape);
    if (SharedPrefController().gender == 'M') {
      genderimagemale = true;
    } else {
      genderimagemale = false;
    }

    return Scaffold(
        backgroundColor: Color(0xFFF7F7F7),
        body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: Landscape * 0.059),
            children: [
              Stack(children: [
                Container(
                    margin: EdgeInsets.only(left: 130),
                    width: 130,
                    height: 130,
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
                      ),
                    )),

                // Image(
                //   image: AssetImage('images/Logo.png'),
                //   height: Landscape * 0.0594,
                //   width: portrait * 0.0138,
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Stack(children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: Landscape * 0.164, left: 10, right: 10),
                      child: AppTextField(
                        hintText: 'Name',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF222B45),
                        ),
                        color: Color(0xFFF7F7F7),
                        controller: _fullNAmeTextController,
                      ),
                    ),
                    Container(
                      width: Portrait * 0.893,
                      height: Landscape * 0.064,
                      decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(16)),
                      margin: EdgeInsets.only(
                          top: Landscape * 0.27, left: 10, right: 10),
                      child: Padding(
                        padding: EdgeInsets.only(left: portrait * 0.12),
                        child: FutureBuilder<List<cities>>(
                            future: _city,
                            builder: (context, snapshot) {
                              Cities = snapshot.data ?? [];

                              //                     if (snapshot.connectionState == ConnectionState.waiting) {
                              //                       return Transform.scale(
                              //                         scale: 0.3,
                              //                         child: CircularProgressIndicator(),
                              //                       );
                              //                     } else
                              // if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                              return DropdownButton<int>(
                                // Initial Value
                                // hint: snapshot.hasData
                                //     ? Text(Cities[SharedPrefController().city]
                                //         .nameEn)
                                //     : SizedBox(
                                //         child: CircularProgressIndicator(
                                //           color: Colors.grey,
                                //         ),
                                //         height: 20.0,
                                //         width: 20.0,
                                //       ),
                                isExpanded: true,
                                onTap: () {},
                                elevation: 4,
                                value: selectedcity,
                                onChanged: (int? value) {
                                  if (value != null) {
                                    setState(() {
                                      selectedcity = value;
                                    });
                                  }
                                },
                                items: Cities.map(
                                  (e) => DropdownMenuItem(
                                    child: Text(e.nameEn),
                                    value: e.id,
                                  ),
                                ).toList(),
                              );
                            }),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: Landscape * 0.29, left: portrait * 0.05),
                      child: Icon(
                        Icons.location_city,
                        color: Color(0xFF222B45),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: Landscape * 0.374),
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
                                 _gender= value;
                              });
                            }
                          },
                        ))
                      ]),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Landscape * 0.504, left: 80, right: 10),
                        child: Container(
                          width: Portrait * 0.603,
                          height: Landscape * 0.064,
                          decoration: BoxDecoration(
                            color: Color(0xFF4E55AF),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextButton(
                            //       child: const Text('LOGIN'),
                            //       style: ElevatedButton.styleFrom(
                            //         minimumSize: const Size(500,56),
                            onPressed: ()async{
                               // String fcmRandonToken=randomString(20);
                               // print(fcmRandonToken);
                               // UserStore userstore = UserStore();
                               // userstore.fcmToken=fcmRandonToken;
                              await _performRegister();},
                            child: Text('Save edits'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: 135,
                        margin: EdgeInsets.only(top: Landscape * 0.664),
                        child: Divider(color: Colors.grey)),

                    Padding(
                      padding: EdgeInsets.only(top: Landscape * 0.66,left:135),
                      child: Text(
                        'change password',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                        width: 135,
                        margin: EdgeInsets.only(top: Landscape * 0.664,left: 260),
                        child: Divider(color: Colors.grey,)),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Landscape * 0.70, left: 10, right: 10),
                      child: AppTextFieldP(
                          controller: _passwordTextController,
                          obscureText: _obscureText,
                          hintText: 'current Password',
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
                    Padding(
                      padding: EdgeInsets.only(
                          top: Landscape * 0.80, left: 10, right: 10),
                      child:AppTextFieldP(
                          controller: _NewPasswordTextController,
                          obscureText: _obscureTextNew,
                          hintText: 'New Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xFF222B45),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureTextNew = !_obscureTextNew;
                              });
                            },
                            icon: Icon(_obscureTextNew
                                ? Icons.visibility
                                : Icons.visibility_off),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Landscape * 0.90, left: 10, right: 10),
                      child: AppTextFieldP(
                          controller: _confirmPassword,
                          obscureText: _obscureTextConfirm,
                          hintText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xFF222B45),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureTextConfirm = !_obscureTextConfirm;
                              });
                            },
                            icon: Icon(_obscureTextConfirm
                                ? Icons.visibility
                                : Icons.visibility_off),
                          )),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Landscape * 1.004, left: 80, right: 10),
                        child: Container(
                          width: Portrait * 0.603,
                          height: Landscape * 0.064,
                          decoration: BoxDecoration(
                            color: Color(0xFF4E55AF),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextButton(
                            //       child: const Text('LOGIN'),
                            //       style: ElevatedButton.styleFrom(
                            //         minimumSize: const Size(500,56),
                            onPressed: () async => _performpasswpord(),
                            child: Text('Save edits'),
                          ),
                        ),
                      ),
                    ),
                  ]),
                )
              ]),
            ],),);
  }

  Future<bool> _performRegister() async {
    if (_checkData()) {

      Editinformation();
      return true;
    } else {
      return false;
    }
  }

  bool _checkData() {
    if (_fullNAmeTextController.text.isNotEmpty&&selectedcity!=null) {
      return true;
    }
    //TODO: SHOW SNACK BAR
    showSnackBar(
      context: context,
      message: 'Enter required data to name or city',
      error: true,
    );
    return false;
  }

  Future<void> Editinformation() async {
    //await AuthApiController().FcmToken(context);
   await AuthApiController().Updateinformation(context, userStore: userstores);
   await AuthApiController().Login(context,mobile: SharedPrefController().phon, passwor:SharedPrefController().password);
  }
    // if (statas) {
    //   Future.delayed(const Duration(seconds: 5), () {
    //     Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => ActivationCode(
    //                   mobile: _phonTextController.text,
    //                 )));
    //   });
    // }


  UserStore get userstores {
    UserStore userstore = UserStore();
    userstore.token=SharedPrefController().token;
    userstore.name = _fullNAmeTextController.text;
    userstore.cityId = Cities[selectedcity!-1].id.toString();
    print('kokokokok'+Cities[selectedcity!-1].id.toString());
    userstore.gender = _gender!;
    userstore.id=SharedPrefController().id;
    userstore.fcmToken=randomString(20).toString();
    userstore.mobile=SharedPrefController().phon;
    SharedPrefController().save(userstore: userstore, password: SharedPrefController().password);
    return userstore;
  }
  Future<bool> _performpasswpord() async {
    if (_checkpassword()) {
      Changepasswored();
      return true;
    } else {
      return false;
    }
  }

  bool _checkpassword() {
    if (_passwordTextController.text.isNotEmpty&&_NewPasswordTextController.text.isNotEmpty&&_confirmPassword.text.isNotEmpty) {
      return true;
    }
    //TODO: SHOW SNACK BAR
    showSnackBar(
      context: context,
      message: 'Enter required data to name or city',
      error: true,
    );
    return false;
  }

  Future<void> Changepasswored() async {
    //await AuthApiController().FcmToken(context);
    await AuthApiController().Passwordchange(context, passwordChange: passwordchange);
    await AuthApiController().Login(context, mobile: SharedPrefController().phon, passwor:_NewPasswordTextController.text );

  }

  PasswordChange get passwordchange {
    PasswordChange passwordchang = PasswordChange();
    passwordchang.password=_passwordTextController.text;
    passwordchang.NewPAssword=_NewPasswordTextController.text;
    passwordchang.ConfirmPAssword=_confirmPassword.text;
    return passwordchang;
  }
}
