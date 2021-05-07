import 'package:PROWORK/utills/appConstraints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static void setLoginStatus() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs?.setBool(AppConstants.loginInfoKey, true);
  }

  static Future<bool> getLoginStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var status = preferences.getBool(AppConstants.loginInfoKey) ?? false;
    return status;
  }

  static void setBasicInfoStatus(bool value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs?.setBool(AppConstants.userBasicInfoKey, true);
  }

  static Future<bool> getBasicInfoStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var status = preferences.getBool(AppConstants.userBasicInfoKey) ?? false;
    return status;
  }

  static void setUserInfo(String documentId, String phoneNumber) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setString(AppConstants.userPhoneNumberKey, phoneNumber);
    _sharedPreferences.setString(AppConstants.userDocumentIDKey, documentId);
  }

  static Future<String> getUserPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phoneNumber = prefs.getString(AppConstants.userPhoneNumberKey);
    return phoneNumber;
  }

  static Future<String> getUserDocumentId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString(AppConstants.userDocumentIDKey);
    return id;
  }
}
