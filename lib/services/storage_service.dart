import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class StorageService {
  static const String _userKey = "user_profile";

  /// Save User
  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _userKey, jsonEncode(user.toJson()),
    );
  }

  /// Load User
  static Future<UserModel?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(_userKey);

    if (data == null) return null;

    return UserModel.fromJson(
      jsonDecode(data),
    );
  }

  /// Check if profile exists
  static Future<bool> hasProfile() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(_userKey);
  }

  /// Delete profile (useful later)
  static Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_userKey);
  }
}