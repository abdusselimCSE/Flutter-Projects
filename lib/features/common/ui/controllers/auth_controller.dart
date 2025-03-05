import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sum_app/features/auth/data/models/auth_success_model.dart';

class AuthController {
  final String _accessTokenKey = 'access_token';
  final String _profileDataKey = 'profile_data'; // Fixed Key Name

  String? accessToken;
  User? profileModel;

  Future<void> saveUserData(String accessToken, User userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    print("🔹 Saving Access Token: $accessToken"); // Debugging
    print(
        "🔹 Saving User Data: ${jsonEncode(userModel.toJson())}"); // Debugging

    await sharedPreferences.setString(_accessTokenKey, accessToken);
    await sharedPreferences.setString(
        _profileDataKey, jsonEncode(userModel.toJson())); // Correct Key

    this.accessToken = accessToken; // Update in-memory access token
    profileModel = userModel;
  }

  Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString(_accessTokenKey);

    print("🔹 Retrieved Access Token: $accessToken"); // Debugging

    String? userData = sharedPreferences.getString(_profileDataKey);
    if (userData != null) {
      profileModel = User.fromJson(jsonDecode(userData));
    }
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);

    if (token != null && token.isNotEmpty) {
      await getUserData();
      return true;
    }
    return false;
  }

  Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    accessToken = null;
    profileModel = null;
  }
}
