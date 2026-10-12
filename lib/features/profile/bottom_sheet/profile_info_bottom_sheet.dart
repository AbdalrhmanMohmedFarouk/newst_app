import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:newst_app/core/datasource/preferences_manger.dart';
import 'package:newst_app/core/widgets/custom_text_form_field.dart';

class ProfileInfoBottomSheet extends StatefulWidget {
  const ProfileInfoBottomSheet({super.key});

  @override
  State<ProfileInfoBottomSheet> createState() => _ProfileInfoBottomSheetState();
}

class _ProfileInfoBottomSheetState extends State<ProfileInfoBottomSheet> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    usernameController.text = PreferencesManger().getString("username") ?? "";
    emailController.text = PreferencesManger().getString("user_email") ?? "";
  }

  void _saveUserData() async {
    if (_key.currentState?.validate() ?? false) {
      await PreferencesManger().setString("username", usernameController.text);
      await PreferencesManger().setString("user_email", emailController.text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.radius(16)),
          topRight: Radius.circular(AppSizes.radius(16)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.sizeW(16),
          vertical: AppSizes.sizeH(16),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: AppSizes.sizeW(42),
                    height: AppSizes.sizeH(4),
                    decoration: BoxDecoration(
                      color: Color(0xFF363636),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.sizeH(16)),

                Text(
                  "Profile Info",
                  style: TextStyle(
                    color: Color(0xFF141414),
                    fontSize: AppSizes.fontSize(16),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: AppSizes.sizeH(24)),
                CustomTextFormField(
                  controller: usernameController,
                  title: "User Name",
                  hintText: "Abdalrhman Mohmed",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter User Name';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: emailController,
                  title: "Email",
                  hintText: "Abdalrhman@gmail.com",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                    if (!regex.hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),

                SizedBox(height: AppSizes.sizeH(16)),
                ElevatedButton(
                  onPressed: () {
                    _saveUserData();
                  },
                  child: Text("Save"),
                ),
                SizedBox(height: AppSizes.sizeH(16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
