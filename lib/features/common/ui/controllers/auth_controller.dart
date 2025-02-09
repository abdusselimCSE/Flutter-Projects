import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sum_app/features/auth/data/models/profile_model.dart';

class AuthController {
  final String _accessTokenKey = 'access_token';
  final String _profileDataKey = 'access_token';

  String? accessToken;
  ProfileModel? profileModel;

  Future<void> saveUserData(String accessToken, ProfileModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, accessToken);
    sharedPreferences.setString(_profileDataKey, jsonEncode(model.toJson()));
  }

  Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString(_accessTokenKey);
    profileModel = ProfileModel.fromJson(
        jsonDecode(sharedPreferences.getString(_profileDataKey)!));
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    if (token != null) {
      await getUserData();
      return true;
    }
    return false;
  }

  Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
