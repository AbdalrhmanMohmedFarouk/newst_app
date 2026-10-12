import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newst_app/core/datasource/preferences_manger.dart';
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

  getUserData() {
    userName = PreferencesManger().getString("username") ?? "";
    countryName = PreferencesManger().getString("countryName") ;
    countryCode = PreferencesManger().getString("countryCode") ;
    countryFlag = PreferencesManger().getString("countryFlag") ;
    safeNotify();
  }

  saveCountry(Country selectedCountry) async {
    await PreferencesManger().setString(
      "countryName",
      selectedCountry.displayName,
    );
    await PreferencesManger().setString(
      "countryCode",
      selectedCountry.countryCode,
    );
    await PreferencesManger().setString(
      "countryFlag",
      selectedCountry.flagEmoji,
    );
    countryName = selectedCountry.name;
    countryCode = selectedCountry.countryCode;
    countryFlag = selectedCountry.flagEmoji;
    safeNotify();
  }
}
