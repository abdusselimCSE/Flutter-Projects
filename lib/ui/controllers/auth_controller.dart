import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sum_app/data/models/user_model.dart';

class AuthController {
  static const String _accessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';
  static const String _resetEmail = 'reset-email';
  static const String _otp = 'otp';

  static String? accessToken;
  static UserModel? userData;
  static String? resetEmail;
  static String? otp;

  static Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  static Future<void> saveUserData(UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        _userDataKey, jsonEncode(userModel.toJson()));
    userData = userModel;
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    accessToken = token;
    return token;
  }

  static Future<UserModel?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEncodedData = sharedPreferences.getString(_userDataKey);
    if (userEncodedData == null) {
      return null;
    }
    UserModel userModel = UserModel.fromJson(jsonDecode(userEncodedData));
    userData = userModel;
    return userModel;
  }

  static Future<String?> getResetEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? resetEmailC = sharedPreferences.getString(_resetEmail);
    resetEmail = resetEmailC;
    return resetEmailC;
  }

  static Future<void> saveResetEmail(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_resetEmail, email);
    resetEmail = email;
  }

  static Future<String?> getOtp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? otpC = sharedPreferences.getString(_otp);
    otp = otpC;
    return otpC;
  }

  static Future<void> saveOtp(String otpP) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_otp, otpP);
    otp = otpP;
  }

  static bool isLoggedIn() {
    return accessToken != null;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    accessToken = null;
  }
}
