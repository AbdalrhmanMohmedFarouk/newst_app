import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newst_app/core/datasource/local_data/user_repository.dart';
import 'package:newst_app/core/mixins/safe_notify_mixin.dart';
import 'package:newst_app/core/models/user_model.dart';

class ProfileController extends ChangeNotifier with SafeNotify {
  XFile? selectedImage;

  String? userName;
  String? userEmail;

  String? selectedCountry;
  String? countryName;
  String? countryCode;
  String? countryFlag;

  void pickImage(ImageSource source) async {
    selectedImage = await ImagePicker().pickImage(source: source);
    safeNotify();
  }

  void getUserData() {
    final UserModel? user = UserRepository().getUser();
    userName = user?.name;
    userEmail = user?.email;
    countryName = user?.countryName;
    countryCode = user?.countryCode;
    countryFlag = user?.countryFlag;
    safeNotify();
  }

  Future<void> saveCountry(Country selectedCountry) async {
    final name = selectedCountry.name;
    final code = selectedCountry.countryCode;
    final flag = selectedCountry.flagEmoji;

    await UserRepository().updateUser(
      countryName: name,
      countryCode: code,
      countryFlag: flag,
    );

    countryName = name;
    countryCode = code;
    countryFlag = flag;
    safeNotify();
  }
}
