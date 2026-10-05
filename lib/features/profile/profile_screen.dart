import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:newst_app/core/datasource/preferences_manger.dart';
import 'package:newst_app/core/theme/light_color.dart';
import 'package:newst_app/core/widgets/custom_svg_picture.dart';
import 'package:newst_app/features/auth/login_screen.dart';
import 'package:newst_app/features/profile/profile_controller.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileController>(
      create: (BuildContext context) {
        return ProfileController();
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: Center(
          child: Consumer<ProfileController>(
            builder:
                (
                  BuildContext context,
                  ProfileController controller,
                  Widget? child,
                ) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizes.sizeH(24),
                      horizontal: AppSizes.sizeW(12),
                    ),
                    child: Column(
                      crossAxisAlignment: .center,
                      children: [
                        SizedBox(height: 28),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: AppSizes.radius(60),
                              backgroundImage: controller.selectedImage == null
                                  ? AssetImage("assets/images/person.png")
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
                                  borderRadius: BorderRadius.circular(
                                    AppSizes.radius(90),
                                  ),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: AppSizes.sizeH(25),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.sizeH(8)),
                        Text(
                          PreferencesManger().getString("username") ??
                              "".toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: AppSizes.fontSize(16),
                          ),
                        ),
                        SizedBox(height: AppSizes.sizeH(36)),
                        _buildProfileItem(
                          "Personal Info",
                          "assets/svg/personalinfo.svg",
                          () {},
                        ),
                        _buildProfileItem(
                          "Language",
                          "assets/svg/language.svg",
                          () {},
                        ),
                        _buildProfileItem(
                          "Country",
                          "assets/svg/country.svg",
                          () {},
                        ),
                        _buildProfileItem(
                          "Terms & Conditions",
                          "assets/svg/terms&conditions.svg",
                          () {},
                        ),
                        _buildProfileItem(
                          "Logout",
                          "assets/svg/logout.svg",
                          () async {
                            PreferencesManger().clear();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                          color: LightColors.primaryColor,
                          divider: false,
                        ),
                      ],
                    ),
                  );
                },
          ),
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
                  Icon(Icons.camera_alt, size: AppSizes.radius(20)),
                  SizedBox(width: AppSizes.sizeW(5)),
                  Text(
                    "Open Camera",
                    style: TextStyle(fontSize: AppSizes.fontSize(12)),
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
                  Icon(Icons.photo_library, size: AppSizes.radius(20)),
                  SizedBox(width: AppSizes.sizeW(5)),
                  Text(
                    "Choose From Gallery",
                    style: TextStyle(fontSize: AppSizes.fontSize(12)),
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

Widget _buildProfileItem(
  String title,
  String path,
  Function onTap, {
  Color color = const Color(0xFF161F1B),
  bool divider = true,
}) {
  return Column(
    children: [
      ListTile(
        onTap: () => onTap(),
        title: Text(
          title,
          style: TextStyle(
            fontSize: AppSizes.fontSize(16),
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
        leading: CustomSvgPicture.withoutColor(
          path: path,
          height: AppSizes.sizeH(16),
          width: AppSizes.sizeW(16),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.sizeH(8)),
        trailing: Icon(Icons.arrow_forward_ios, color: color),
      ),
      if (divider) Divider(color: Colors.grey.shade300),
    ],
  );
}
