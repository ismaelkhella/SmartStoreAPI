import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartsstors/model/userstore.dart';

enum PrefKeys { loggedIn, id, r, phon, gender, token,city,password,newtoken,fcmtoken,jj,ff,total }

class SharedPrefController {
  static final SharedPrefController _instance = SharedPrefController._();
  late SharedPreferences _sharedPreferences;

  factory SharedPrefController() {
    return _instance;
  }

  SharedPrefController._();

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required UserStore userstore,required String password}) async {
    print(userstore.cityId.toString());
    await _sharedPreferences.setBool(PrefKeys.loggedIn.toString(), true);
    await _sharedPreferences.setInt(PrefKeys.id.toString(), userstore.id);
    await _sharedPreferences.setString(
        PrefKeys.r.toString(), userstore.name);
    await _sharedPreferences.setString(
        PrefKeys.gender.toString(), userstore.gender);
    await _sharedPreferences.setString(
        PrefKeys.token.toString(), 'Bearer ' + userstore.token);
    await _sharedPreferences.setString(
        PrefKeys.newtoken.toString(),'Bearer '+userstore.refreshToken!);
    await _sharedPreferences.setString(
        PrefKeys.phon.toString(), userstore.mobile);
    await _sharedPreferences.setString(
        PrefKeys.fcmtoken.toString(), userstore.fcmToken!);
    await _sharedPreferences.setString(
        PrefKeys.password.toString(),password);
    await _sharedPreferences.setString(
        PrefKeys.city.toString(),userstore.cityId);

  }
  Future<void>savees({required bool f,required int d})async{
    await _sharedPreferences.setBool(PrefKeys.jj.toString(), f);
    await _sharedPreferences..setInt(PrefKeys.ff.toString(), d);
  }


  bool get jj =>
      _sharedPreferences.getBool(PrefKeys.jj.toString()) ?? false;

  int get ff =>
      _sharedPreferences.getInt(PrefKeys.ff.toString()) ?? 0;


  bool get loggedIn =>
      _sharedPreferences.getBool(PrefKeys.loggedIn.toString()) ?? false;
  int get id =>
      _sharedPreferences.getInt(PrefKeys.id.toString()) ?? 0;

  String get token =>
      _sharedPreferences.getString(PrefKeys.token.toString()) ?? '';

  String get tokenNEw =>
      _sharedPreferences.getString(PrefKeys.newtoken.toString()) ?? '';

  String get password=>
  _sharedPreferences.getString(PrefKeys.password.toString()) ?? '';

  String get phon=>
  _sharedPreferences.getString(PrefKeys.phon.toString()) ?? '';

  String get name=>
  _sharedPreferences.getString(PrefKeys.r.toString()) ?? '';

  String get gender=>
  _sharedPreferences.getString(PrefKeys.gender.toString()) ?? '';

String get fcmtoken=>
  _sharedPreferences.getString(PrefKeys.fcmtoken.toString()) ?? '';

   String get city=>
  _sharedPreferences.getString(PrefKeys.city.toString()) ?? '';



  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }
}
