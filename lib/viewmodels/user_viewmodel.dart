import 'dart:io';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class UserViewModel extends ChangeNotifier {
  UserModel? _user;

  final ImagePicker _picker = ImagePicker();

  UserModel? get user => _user;

  bool get hasProfile => _user != null;

  /// Load user from SharedPreferences
  Future<void> loadUser() async {
    _user = await StorageService.loadUser();
    notifyListeners();
  }

  /// Pick image from gallery
  Future<File?> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return null;

    return File(image.path);
  }

  /// Save profile
  Future<void> saveProfile({
    required String name,
    required String imagePath,
  }) async {
    _user = UserModel(
      name: name.trim(),
      imagePath: imagePath,
      isProfileCompleted: true,
    );

    await StorageService.saveUser(_user!);

    notifyListeners();
  }

  /// Update name
  Future<void> updateName(String newName) async {
    if (_user == null) return;

    _user = _user!.copyWith(
      name: newName.trim(),
    );

    await StorageService.saveUser(_user!);

    notifyListeners();
  }

  /// Update image
  Future<void> updateImage(String imagePath) async {
    if (_user == null) return;

    _user = _user!.copyWith(
      imagePath: imagePath,
    );

    await StorageService.saveUser(_user!);

    notifyListeners();
  }

  /// Clear profile (optional)
  Future<void> clearProfile() async {
    await StorageService.clearProfile();

    _user = null;

    notifyListeners();
  }
}