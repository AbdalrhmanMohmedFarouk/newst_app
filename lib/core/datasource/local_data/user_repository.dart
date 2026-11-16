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
      throw Exception("UserRepository not initialized. Call init() first.");
    }
    return _userBox!;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    _userBox = await Hive.openBox(Constants.userBox);
  }

  Future<void> saveUser(UserModel user) async {
    await userBox.put(Constants.currentUser, user);
    if (user.email != null && user.email!.isNotEmpty) {
      await userBox.put(user.email!.trim().toLowerCase(), user);
    }
  }

  UserModel? getUser() {
    return userBox.get(Constants.currentUser);
  }

  Future<void> updateUser({
    String? name,
    String? email,
    String? password,
    String? countryName,
    String? countryCode,
    String? countryFlag,
  }) async {
    final UserModel? user = getUser();
    final updatedUser = (user != null)
        ? user.copyWith(
            name: name,
            email: email,
            password: password,
            countryName: countryName,
            countryCode: countryCode,
            countryFlag: countryFlag,
          )
        : UserModel(
            name: name ?? "User Name",
            email: email ?? "",
            password: password,
            countryName: countryName,
            countryCode: countryCode,
            countryFlag: countryFlag,
          );
    await saveUser(updatedUser);
  }

  Future<void> delete() async {
    await userBox.delete(Constants.currentUser);
  }

  Future<void> clearAll() async {
    await userBox.clear();
  }

  String? login(String email, String password) {
    final cleanEmail = email.trim().toLowerCase();

    // 1. Check if user is found by email key
    UserModel? user = userBox.get(cleanEmail);

    // 2. Fallback to currentUser if email matches
    if (user == null) {
      final current = getUser();
      if (current != null && current.email?.trim().toLowerCase() == cleanEmail) {
        user = current;
      }
    }

    if (user == null || user.email == null) {
      return "No account found with this email. Please register first.";
    }

    if (user.password != password) {
      return "Incorrect password. Please try again.";
    }

    // Set as active user
    userBox.put(Constants.currentUser, user);
    return null;
  }

  Future<String?> singUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final cleanEmail = email.trim().toLowerCase();

    // Check if an account with this exact email already exists
    final existingUser = userBox.get(cleanEmail);
    if (existingUser != null && existingUser.email != null) {
      return "An account with this email already exists. Please sign in.";
    }

    final newUser = UserModel(
      name: name.trim(),
      email: cleanEmail,
      password: password,
    );

    // Save under the email key and set as the current active user
    await userBox.put(cleanEmail, newUser);
    await userBox.put(Constants.currentUser, newUser);

    return null;
  }
}
