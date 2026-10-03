import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
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
                              backgroundImage: AssetImage(
                                "assets/images/person.png",
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
          SimpleDialogOption(onPressed: () {}, child: Text("Open Camera")),
        ],
      );
    },
  );
}
