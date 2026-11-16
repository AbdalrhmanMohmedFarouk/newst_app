import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newst_app/core/datasource/local_data/user_repository.dart';
import 'package:newst_app/core/mixins/safe_notify_mixin.dart';

class ProfileController extends ChangeNotifier with SafeNotify {
  XFile? selectedImage;

  String? userName;

  String? selectedCountry;
  String? countryName;
  String? countryCode;
  String? countryFlag;

  void pickImage(ImageSource source) async {
    selectedImage = await ImagePicker().pickImage(source: source);
    safeNotify();
  }

  getUserData() async {
    final user = await UserRepository().getUser();
    userName = user?.name ?? "";
    countryName = user?.countryName;
    countryCode = user?.countryCode;
    countryFlag = user?.countryFlag;
    safeNotify();
  }

  saveCountry(Country selectedCountry) async {
    await UserRepository().updateUser(
      countryName: selectedCountry.displayName,
      countryCode: selectedCountry.countryCode,
      countryFlag: selectedCountry.flagEmoji,
    );
    countryName = selectedCountry.displayName;
    countryCode = selectedCountry.countryCode;
    countryFlag = selectedCountry.flagEmoji;
    safeNotify();
  }
}
