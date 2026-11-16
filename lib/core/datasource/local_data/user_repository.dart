import 'dart:math';

import 'package:hive_ce_flutter/adapters.dart';
import 'package:newst_app/core/constants/constants.dart';
import 'package:newst_app/core/models/user_model.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._();

  UserRepository._();

  factory UserRepository() {
    return _instance;
  }

  Box<UserModel>? _userBox;

  Box<UserModel> get userBox {
    if (_userBox == null) {
      throw Exception("ser");
    }
    return _userBox!;
  }

  init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    _userBox = await Hive.openBox(Constants.userBox);
  }

  saveUser(UserModel user) async {
    await userBox.put(Constants.currentUser, user);
  }

  getUser() async {
    return await userBox.get(Constants.currentUser);
  }

  updateUser({
    String? name,
    String? email,
    String? password,
    String? countryName,
    String? countryCode,
    String? countryFlag,
  }) async {
    final UserModel? user = getUser();
    if (user != null) {
      final updatedUser = user.copyWith(
        name: name,
        email: email,
        password: password,
        countryName: countryName,
        countryCode: countryCode,
        countryFlag: countryFlag,
      );
      await saveUser(updatedUser);
    }
  }

  delete() async {
    await userBox.delete(Constants.currentUser);
  }

  clearAll() async {
    await userBox.clear();
  }

  String? login(String email, String password) {
    final user = getUser();
    if (user == null) {
      return "No Account Found Please Register First";
    }
    if (user.email != email || user.password != password) {
      return "Incorrect Email or Password";
    }
    return null;
  }

  Future<String?> singUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final user = getUser();
    if (user != null) {
      return "User Already exist Please login";
    }
    if (user.email != email || user.password != password) {
      return " Email is Already Found ";
    }
    final newUser = UserModel(name: name, email: email, password: password);
    await saveUser(newUser);
    return null;
  }
}
