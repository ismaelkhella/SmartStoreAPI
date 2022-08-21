import 'dart:convert';
import 'dart:io';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:smartsstors/Auth/helpers.dart';
import 'package:smartsstors/Auth/sheet_code_activation.dart';
import 'package:smartsstors/model/apiresponscategory.dart';
import 'package:smartsstors/model/category.dart';
import 'package:smartsstors/model/categoryhome.dart';
import 'package:smartsstors/model/data.dart';
import 'package:smartsstors/model/famous_products_home.dart';
import 'package:smartsstors/model/favoraite.dart';
import 'package:smartsstors/model/fvoraiteproduct.dart';
import 'package:smartsstors/model/latestprouducthome.dart';
import 'package:smartsstors/model/listproduct.dart';
import 'package:smartsstors/model/logininformation.dart';
import 'package:smartsstors/model/offer.dart';
import 'package:smartsstors/model/passworedChange.dart';
import 'package:smartsstors/model/product.dart';
import 'package:smartsstors/model/productoffer.dart';
import 'package:smartsstors/model/productonesearch.dart';
import 'package:smartsstors/model/productsearch.dart';
import 'package:smartsstors/model/productsmodel.dart';
import 'package:smartsstors/model/sliderss.dart';
import 'package:smartsstors/model/api_base_response.dart';
import 'package:smartsstors/model/apiresponssliders.dart';
import 'package:smartsstors/model/cities.dart';
import 'package:smartsstors/model/supcategoryproduct.dart';
import 'package:smartsstors/model/userstore.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';

import 'api_settings.dart';

class AuthApiController with Sheetcodeactivation, Helpers {
  late String l;
  late String f;

  Future<bool> register(BuildContext context,
      {required UserStore userStore}) async {
    var url = Uri.parse(ApiSettings.register);
    var response = await http.post(
      url,
      body: {
        'name': userStore.name,
        'mobile': userStore.mobile,
        'password': userStore.password,
        'gender': userStore.gender,
        'city_id': userStore.cityId.toString(),
        'STORE_API_KEY': userStore.STORE_API_KEY,
      },
    );
    if (response.statusCode == 201) {
      ModalBottomSheetMenucode(
        context: context,
        messagereplay: jsonDecode(response.body)['message'].toString(),
        code: jsonDecode(response.body)['code'].toString(),
      );
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: 'Somthine went wrong, try again!',
        error: true,
      );
    }

    return false;
  }
  Future<bool> FcmToken(BuildContext context) async {
    var url = Uri.parse(ApiSettings.updatescreen);
    var response = await http.post(
      url,
      body: {
        'fcm_token': SharedPrefController().fcmtoken,
      },headers: {
        'Authorization':SharedPrefController().token,

    });
     if (response.statusCode == 200) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: false);
      return true;
    } else if (response.statusCode == 201) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: response.body.toString(),
        error: true,
      );
    }

    return false;
  }

  Future<bool> Updateinformation(BuildContext context,
      {required UserStore userStore}) async {
    var url = Uri.parse(ApiSettings.updateinformation);
    var response = await http.post(
      url,
      body: {
        'city_id': userStore.cityId.toString(),
        'name': userStore.name,
        'gender': userStore.gender,
      },headers: {
      'Authorization':SharedPrefController().token.toString(),

    }
    );
    if (response.statusCode == 200) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'].toString(),
          error: false);
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: response.body,
        error: true,
      );
    }

    return false;
  }
  Future<bool> Passwordchange(BuildContext context,
      {required PasswordChange passwordChange}) async {
    var url = Uri.parse(ApiSettings.passwordchange);
    var response = await http.post(
      url,
      body: {
        'current_password': passwordChange.password,
        'new_password': passwordChange.NewPAssword,
        'new_password_confirmation': passwordChange.ConfirmPAssword,

      },headers:{'Authorization':SharedPrefController().token});
    if (response.statusCode == 200){
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'].toString(),
          error: false);
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: response.body,
        error: true,
      );
    }

    return false;
  }
  Future<List<cities>> getCities(BuildContext context) async {
    var url = Uri.parse(ApiSettings.cities);
    var response = await http
        .get(url, headers: {HttpHeaders.acceptHeader: 'application/json'});
    if (response.statusCode == 200) {
      showSnackBar(context: context, message: response.headers.toString());
      var josnRespone = jsonDecode(response.body);
      var apiBaseRespone = ApiBaseResponse.fromJson(josnRespone);
      return apiBaseRespone.list;
    }

    return [];
  }

  Future<bool> Activation(BuildContext context, UserStore userStore) async {
    var url = Uri.parse(ApiSettings.activation);
    var response = await http.post(
      url,
      body: {
        'mobile': userStore.mobile,
        'code': userStore.actives,
      },
    );
    if (response.statusCode == 200) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: false);
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: 'Somthine went wrong, try again!',
        error: true,
      );
    }

    return false;
  }

  Future<bool> Login(BuildContext context,
      {required String mobile, required String passwor}) async {
    var url = Uri.parse(ApiSettings.login);
    var response = await http.post(
      url,
      body: {
        'mobile': mobile,
        'password': passwor,
        'fcm_token':randomString(20),

      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      UserStore userstore = UserStore.fromJson(jsonResponse['data']);
      await SharedPrefController()
          .save(userstore: userstore, password: passwor);
      showSnackBar(
        context: context,
        message: jsonResponse['message'],
      );
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: 'Somthine went wrong, try again!',
        error: true,
      );
    }

    return false;
  }

  Future<bool> favoraite(BuildContext context,
      {required int? product_id}) async {
    var url = Uri.parse(ApiSettings.favarite);
    var response = await http.post(
      url,
      body: {
        'product_id': product_id.toString(),
      },headers: {
      'Authorization':SharedPrefController().token
    }
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      showSnackBar(
        context: context,
        message: jsonResponse['message'],
      );
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: 'Somthine went wrong, try again!',
        error: true,
      );
    }

    return false;
  }

  Future<UserStore?> Loginread(
      {required String mobile, required String passwor}) async {
    var url = Uri.parse(ApiSettings.login);
    var response = await http.post(url, body: {
      'mobile': mobile,
      'password': passwor,
    }, headers: {
      'Authorization':SharedPrefController().token
    });
    if (response.statusCode == 200) {
      String responsbody = response.body;
      print(responsbody);
      var jsonResponsee = jsonDecode(response.body);
      print(jsonResponsee);
      var apiBaseRespone = Logininformation.fromJson(jsonResponsee);
      return apiBaseRespone.data!;
    } else {
      return null;
    }
  }

  Future<bool> forgetPassword(BuildContext context,
      {required String mobile}) async {
    var url = Uri.parse(ApiSettings.forgetPassword);
    var response = await http.post(url, body: {'mobile': mobile});
    if (response.statusCode == 200) {
      print('Code: ${jsonDecode(response.body)['code']}');
      ModalBottomSheetMenucode(
        context: context,
        messagereplay: jsonDecode(response.body)['message'].toString(),
        code: jsonDecode(response.body)['code'].toString(),
      );
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: 'Something went wrong, try again!',
        error: true,
      );
    }
    return false;
  }

  Future<bool> resetPassword(BuildContext context,
      {required String email,
      required String code,
      required String password}) async {
    var url = Uri.parse(ApiSettings.resetPassword);
    var response = await http.post(url, body: {
      'mobile': email,
      'code': code,
      'password': password,
      'password_confirmation': password,
    });

    if (response.statusCode == 200) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
      );
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: 'Something went wrong, try again!',
        error: true,
      );
    }
    return false;
  }

  Future<Data?> getMainhome(BuildContext context) async {
    var url = Uri.parse(ApiSettings.home);
    var response = await http.get(url, headers: {
      'Authorization':SharedPrefController().token
    });
    if (response.statusCode == 200) {
      print(response.request);
      var josnRespone = jsonDecode(response.body);
      var apiBaseRespone = MainHome.fromJson(josnRespone);
      return apiBaseRespone.data;}
    else{showSnackBar(
      context: context,
      message: response.body,
      error: true,
    );}

    return null;
  }  Future<List<FvoraiteProduct?>> getfavoraite(BuildContext context) async {
    var url = Uri.parse(ApiSettings.favoraitescreen);
    var response = await http.get(url, headers: {
      'Authorization':SharedPrefController().token
    });
    if (response.statusCode == 200) {
      print(response.request);
      var josnRespone = jsonDecode(response.body);
      var apiBaseRespone = Favorite.fromJson(josnRespone);
      return apiBaseRespone.favoraiteproduct!;

  }
    return[];
  }
  Future<List<Productsmodel>> getProductDetails(
      {required int id}) async {
    var url = Uri.parse(
        ApiSettings.product.replaceFirst('{id}',id.toString()));
    print(url.toString());
    var response = await http.get(url, headers: {
      'Authorization': SharedPrefController().token
    });
    if (response.statusCode == 200) {
      var dataJsonArray = jsonDecode(response.body);
      print(dataJsonArray.toString());
      var apirespons = Productsubcategory.fromJson(dataJsonArray);
      return apirespons.list;
    }
    return [];
  }
  Future<List<slidersee>> getSlider(BuildContext context) async {
    var url = Uri.parse(ApiSettings.home);
    var response = await http.get(url, headers: {
      'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMzA1NTI4NjI1OTE0YmNhNzllMzlkMmQ0MmNkN2RhN2I2MTVlOWIwNzEwZTg2YjcxYTE1ZGUwNmI0Zjk3YWQ0NWY0YmM0OWVlYmI3ZGE3MTIiLCJpYXQiOjE2NTI5MjU3NDkuNjk1MDkxLCJuYmYiOjE2NTI5MjU3NDkuNjk1MDk2LCJleHAiOjE2NTcyNDU3NDkuNjg5NTI2LCJzdWIiOiIxMDk1Iiwic2NvcGVzIjpbIioiXX0.mP-J2cpzRJb7yIOEUqDwUPXtrfHKgvZd9M0ccGaeOcbGC3oVBwrYveGVUworJurAbzEaYYJqS3ArZb-M-sQSg6TyEDRAdQ-5y5owZWnOynKKrfPWYBqqJ7feea75sIK3H2jbOsfk8HzeVCjUNfvitD9b1KXMExOOxnjgwQKj2GQ8_RY-pqv5Z2Om2LLTaOqHCuVCC1zExNWQOBgyEjgdqeoBaVCPeFwbCZGRR_d8EVjETDbmf3dvQjsL-A4QrHFsRAJiJS7nWoT3t5Yy6UnOomS2LC5LZDIj-Qt1UEwOr4IT7OSV4zsFsIegU86KIzaMzSMrQBeQxZuKZM86LhaXk0_KTYQEVeHFC5rM5KrAkubF6Cmxbyr5oUZdW8DHiSMT2DJYEiO32-QS4UM__Wg_gxS8HDGgZomFT6ebSa54YLlRzwf6CbhKn6ENn907pQk0wOPZ_4yl4sYNWeqIJ5b1oQGnmg4r8dIzQTUberQozyethcAS7gP2CgUqrwpVjY0DSwKOKqyXzYExp2ua8WNUANJcQZ04lXVWRMVvapyQ6sr_Bp8L0BUjX-OaDNwrJ8ZDqDmF5e7rh11-BCROyg5djhT2yPwGnqtJ1qcPJvY9tBk1RqC1MlYlME2xQeZDxfgJODdAYc-nUSWdFfarjQG4Icmn0l4pjGiXwnjUmKuAOzA',
    });
    if (response.statusCode == 200) {
      print(response.request);
      var josnRespone = jsonDecode(response.body);
      var apiBaseRespone = MainHome.fromJson(josnRespone);
      return apiBaseRespone.data.slider;
    }

    return [];
  }

  Future<List<Categories>> getCategorias() async {
    var url = Uri.parse(ApiSettings.home);
    var response = await http.get(url, headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiYjhjMGFlOTc2NDMzMmZhZDk3YmViN2JkMzgwZWQ3N2YwNDE4MTUwNWE5YTFmYzE3N2M5N2E4OGRmZGRhYjliOTBjYjlkOGUwMjJlMDMzYTYiLCJpYXQiOjE2NDg5Mzc5NzYuNzUwNzMyLCJuYmYiOjE2NDg5Mzc5NzYuNzUwNzM1LCJleHAiOjE2NTMyNTc5NzYuNzQyODY2LCJzdWIiOiIxMDAxIiwic2NvcGVzIjpbIioiXX0.S3MsP4bizykp4P8MqEEYMUdY1sx_PnsAPvW1tKfz_Ru3t9bjnjKajFX3XMfocwy8reqYOJaWjvLG7CZ3AhVW58eErnjAu6BkMioD3Wuhsmb-W8RyfJAv3uX1y1dWeDAMDRntT_vWPWzPsoQRhXhkU3zyoorMSuq5G3qP0bHPbm20g9A5UUS2Z5D-3h1L9zXXLNLsxQCpyrgjOgCkDl73MAIxehAAFVn7HdVKs_CvfeBTFnAiO4RPPyjBxpqh9orrgkztsswlY_tilL-ZbiDBU3cV2f2IMiMD91H0Pq1VXAXQDF45oJlgpaycxG_dLrm9ZJ1uhv6LM6EhSQGjiiySqZ6NIT8rDtauKoQM6Xfh-QMdr7WxF76ic7aVM5WG-hDwY6MtrsfZayk4ePZyJxSNbP9x7DTENafFeoEVrE0g24XPRbsw6brX2pJ7p3QkTQqfIwr3qwgCZnohGenq4AwuviDwJNQfr_6Sc1K7HsL4_1jsyOQB_i5xzCTaJuy_5BfGgNbPzSKp8MpY-kx7xcocL_6Crsv1v634Jf-4WVcja5zNaa00Edxv8ie3TwsShrNK-z3hXE_kd52HmL0uVXBertOTwDn2TqS402tgSmEExbcq-sK3RIm-ijPKAc4qWD2rYpEXJ1wtWmXfVxacsaizg0oSMeGAVFeUvOFicCj5EMw'
    });
    if (response.statusCode == 200) {
      print(response.body);
      var josnRespone = jsonDecode(response.body);
      var apiBaseRespone = MainHome.fromJson(josnRespone);
      return apiBaseRespone.data.Categorie;
    }

    return [];
  }

  Future<List<LatestProducts>> getlatestprouduct() async {
    var url = Uri.parse(ApiSettings.home);
    var response = await http.get(url, headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiYjhjMGFlOTc2NDMzMmZhZDk3YmViN2JkMzgwZWQ3N2YwNDE4MTUwNWE5YTFmYzE3N2M5N2E4OGRmZGRhYjliOTBjYjlkOGUwMjJlMDMzYTYiLCJpYXQiOjE2NDg5Mzc5NzYuNzUwNzMyLCJuYmYiOjE2NDg5Mzc5NzYuNzUwNzM1LCJleHAiOjE2NTMyNTc5NzYuNzQyODY2LCJzdWIiOiIxMDAxIiwic2NvcGVzIjpbIioiXX0.S3MsP4bizykp4P8MqEEYMUdY1sx_PnsAPvW1tKfz_Ru3t9bjnjKajFX3XMfocwy8reqYOJaWjvLG7CZ3AhVW58eErnjAu6BkMioD3Wuhsmb-W8RyfJAv3uX1y1dWeDAMDRntT_vWPWzPsoQRhXhkU3zyoorMSuq5G3qP0bHPbm20g9A5UUS2Z5D-3h1L9zXXLNLsxQCpyrgjOgCkDl73MAIxehAAFVn7HdVKs_CvfeBTFnAiO4RPPyjBxpqh9orrgkztsswlY_tilL-ZbiDBU3cV2f2IMiMD91H0Pq1VXAXQDF45oJlgpaycxG_dLrm9ZJ1uhv6LM6EhSQGjiiySqZ6NIT8rDtauKoQM6Xfh-QMdr7WxF76ic7aVM5WG-hDwY6MtrsfZayk4ePZyJxSNbP9x7DTENafFeoEVrE0g24XPRbsw6brX2pJ7p3QkTQqfIwr3qwgCZnohGenq4AwuviDwJNQfr_6Sc1K7HsL4_1jsyOQB_i5xzCTaJuy_5BfGgNbPzSKp8MpY-kx7xcocL_6Crsv1v634Jf-4WVcja5zNaa00Edxv8ie3TwsShrNK-z3hXE_kd52HmL0uVXBertOTwDn2TqS402tgSmEExbcq-sK3RIm-ijPKAc4qWD2rYpEXJ1wtWmXfVxacsaizg0oSMeGAVFeUvOFicCj5EMw'
    });
    if (response.statusCode == 200) {
      print(response.body);
      var josnRespone = jsonDecode(response.body);
      var apiBaseRespone = MainHome.fromJson(josnRespone);
      return apiBaseRespone.data.latestprouduct;
    }

    return [];
  }

  Future<List<famous_products>> getfamuosproduct() async {
    var url = Uri.parse(ApiSettings.home);
    var response = await http.get(url, headers: {
      'Authorization':SharedPrefController().token
    });
    if (response.statusCode == 200) {
      var josnRespone = jsonDecode(response.body);
      var apiBaseRespone = MainHome.fromJson(josnRespone);
      return apiBaseRespone.data.famousproduct;
    }

    return [];
  }

  Future<List<Category>> getCategories() async {
    var url = Uri.parse(ApiSettings.categories);
    var response = await http.get(url, headers: {
      'Authorization':SharedPrefController().token
    });
    if (response.statusCode == 200) {
      print(response.body);
      var dataJsonArray = jsonDecode(response.body);
      var apirespons = ApiResponsecategory.fromJson(dataJsonArray);
      return apirespons.list;
    }
    return [];
  }

  Future<List<ListSubcategory>> getSupcategory(
      {required int id}) async {
    var url = Uri.parse(
        ApiSettings.subcategories.replaceFirst('{id}', id.toString()));
    print(url.toString());
    var response = await http.get(url, headers: {
      'Authorization':SharedPrefController().token});
    if (response.statusCode == 200) {
      print(response.body);
      var dataJsonArray = jsonDecode(response.body);
      var apirespons = Supcategoryproduct.fromJson(dataJsonArray);
      return apirespons.listproduct;
    }
    return [];
  }


  Future<Objectproductone?> getProductone(
      {required int id}) async {
    var url = Uri.parse(ApiSettings.productdeatials.replaceFirst('{id}', id.toString()));
    print(url.toString());
    var response = await http.get(url, headers: {
      'Authorization':SharedPrefController().token});
    if (response.statusCode == 200) {
      print(response.body);
      var dataJsonArray = jsonDecode(response.body);
      var apirespons = Productdescription.fromJson(dataJsonArray);
      return apirespons.object;
    }else{
      return null;
    }
  }

  Future<List<Offers>> getOffers() async {
    var url = Uri.parse(ApiSettings.offers);
    var response = await http.get(url, headers: {
      'Authorization':SharedPrefController().token});
    if (response.statusCode == 200) {
      print(response.body);
      var dataJsonArray = jsonDecode(response.body);
      var apirespons = ProductOffer.fromJson(dataJsonArray);
      return apirespons.offers!;
    }
    return [];
  }
}
