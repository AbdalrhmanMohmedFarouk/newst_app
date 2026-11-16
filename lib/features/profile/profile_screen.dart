import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:newst_app/core/datasource/local_data/preferences_manger.dart';
import 'package:newst_app/core/theme/light_color.dart';
import 'package:newst_app/core/widgets/custom_svg_picture.dart';
import 'package:newst_app/features/auth/login_screen.dart';
import 'package:newst_app/features/profile/profile_controller.dart';
import 'package:provider/provider.dart';

import 'bottom_sheet/profile_info_bottom_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileController>(
      create: (BuildContext context) {
        return ProfileController()..getUserData();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Profile")),
        body: Consumer<ProfileController>(
          builder: (
            BuildContext context,
            ProfileController controller,
            Widget? child,
          ) {
            final displayName = (controller.userName != null &&
                    controller.userName!.trim().isNotEmpty)
                ? controller.userName!
                : (controller.userEmail != null &&
                        controller.userEmail!.trim().isNotEmpty)
                    ? controller.userEmail!.split('@').first
                    : "User Name";

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.sizeH(24),
                horizontal: AppSizes.sizeW(12),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: AppSizes.sizeH(28)),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: AppSizes.radius(60),
                          backgroundImage: controller.selectedImage == null
                              ? const AssetImage(
                                  "assets/images/person.png",
                                )
                              : FileImage(
                                  File(controller.selectedImage!.path),
                                ),
                          backgroundColor: Colors.transparent,
                        ),
                        GestureDetector(
                          onTap: () {
                            showImageSourceDialog(context);
                          },
                          child: Container(
                            height: AppSizes.sizeH(45),
                            width: AppSizes.sizeW(45),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: AppSizes.sizeH(22),
                              color: const Color(0xFF141414),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.sizeH(12)),
                    Text(
                      displayName,
                      style: TextStyle(
                        color: const Color(0xFF141414),
                        fontSize: AppSizes.fontSize(18),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (controller.userEmail != null &&
                        controller.userEmail!.trim().isNotEmpty) ...[
                      SizedBox(height: AppSizes.sizeH(4)),
                      Text(
                        controller.userEmail!,
                        style: TextStyle(
                          color: const Color(0xFF6E7191),
                          fontSize: AppSizes.fontSize(14),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                    SizedBox(height: AppSizes.sizeH(32)),

                    _buildProfileItem(
                      title: "Personal Info",
                      path: "assets/svg/personalinfo.svg",
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return const ProfileInfoBottomSheet();
                          },
                        ).then((value) {
                          controller.getUserData();
                        });
                      },
                    ),

                    _buildProfileItem(
                      title: "Language",
                      path: "assets/svg/language.svg",
                      onTap: () {},
                    ),

                    // Enhanced Country Item
                    _buildProfileItem(
                      title: "Country",
                      subtitle: controller.countryName != null
                          ? controller.countryName!
                          : "Select your country",
                      path: "assets/svg/country.svg",
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (controller.countryFlag != null) ...[
                            Text(
                              controller.countryFlag!,
                              style: TextStyle(
                                fontSize: AppSizes.fontSize(20),
                              ),
                            ),
                            SizedBox(width: AppSizes.sizeW(6)),
                          ],
                          if (controller.countryCode != null) ...[
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.sizeW(8),
                                vertical: AppSizes.sizeH(2),
                              ),
                              decoration: BoxDecoration(
                                color: LightColors.primaryColor
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                  AppSizes.radius(6),
                                ),
                              ),
                              child: Text(
                                controller.countryCode!,
                                style: TextStyle(
                                  fontSize: AppSizes.fontSize(12),
                                  fontWeight: FontWeight.w700,
                                  color: LightColors.primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(width: AppSizes.sizeW(8)),
                          ],
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Color(0xFF161F1B),
                          ),
                        ],
                      ),
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: false,
                          countryListTheme: CountryListThemeData(
                            bottomSheetHeight:
                                MediaQuery.of(context).size.height * 0.7,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(AppSizes.radius(20)),
                            ),
                            inputDecoration: InputDecoration(
                              hintText: 'Search country...',
                              prefixIcon: const Icon(Icons.search),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: AppSizes.sizeW(16),
                                vertical: AppSizes.sizeH(12),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppSizes.radius(12),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppSizes.radius(12),
                                ),
                                borderSide: const BorderSide(
                                  color: LightColors.primaryColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                          onSelect: (Country country) {
                            controller.saveCountry(country);
                          },
                        );
                      },
                    ),

                    _buildProfileItem(
                      title: "Terms & Conditions",
                      path: "assets/svg/terms&conditions.svg",
                      onTap: () {},
                    ),

                    _buildProfileItem(
                      title: "Logout",
                      path: "assets/svg/logout.svg",
                      color: LightColors.primaryColor,
                      divider: false,
                      onTap: () async {
                        await PreferencesManger()
                            .setBool("is_logged_in", false);

                        if (!context.mounted) return;

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const LoginScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void showImageSourceDialog(BuildContext context) {
  final controller = context.read<ProfileController>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(
          "Select Image Source",
          style: TextStyle(fontSize: AppSizes.fontSize(14)),
        ),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              controller.pickImage(ImageSource.camera);
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                AppSizes.sizeH(2),
                0,
                AppSizes.sizeH(2),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt,
                    size: AppSizes.radius(20),
                  ),
                  SizedBox(width: AppSizes.sizeW(5)),
                  Text(
                    "Open Camera",
                    style: TextStyle(
                      fontSize: AppSizes.fontSize(12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              controller.pickImage(ImageSource.gallery);
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                AppSizes.sizeH(2),
                0,
                AppSizes.sizeH(2),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.photo_library,
                    size: AppSizes.radius(20),
                  ),
                  SizedBox(width: AppSizes.sizeW(5)),
                  Text(
                    "Choose From Gallery",
                    style: TextStyle(
                      fontSize: AppSizes.fontSize(12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildProfileItem({
  required String title,
  required String path,
  required VoidCallback onTap,
  Color color = const Color(0xFF161F1B),
  bool divider = true,
  String? subtitle,
  Widget? trailing,
}) {
  return Column(
    children: [
      ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: TextStyle(
            fontSize: AppSizes.fontSize(16),
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(
                  fontSize: AppSizes.fontSize(13),
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6E7191),
                ),
              )
            : null,
        leading: CustomSvgPicture.withoutColor(
          path: path,
          height: AppSizes.sizeH(18),
          width: AppSizes.sizeW(18),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.sizeH(8),
        ),
        trailing: trailing ??
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: color,
            ),
      ),
      if (divider) Divider(color: Colors.grey.shade200),
    ],
  );
}
