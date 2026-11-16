import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:newst_app/core/datasource/local_data/user_repository.dart';
import 'package:newst_app/core/models/user_model.dart';
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
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final UserModel? user = UserRepository().getUser();
    usernameController.text = user?.name ?? "";
    emailController.text = user?.email ?? "";
  }

  void _saveUserData() async {
    if (_key.currentState?.validate() ?? false) {
      await UserRepository().updateUser(
        name: usernameController.text.trim(),
        email: emailController.text.trim(),
      );
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.radius(20)),
          topRight: Radius.circular(AppSizes.radius(20)),
        ),
      ),
      padding: EdgeInsets.only(
        left: AppSizes.sizeW(16),
        right: AppSizes.sizeW(16),
        top: AppSizes.sizeH(16),
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSizes.sizeH(24),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: AppSizes.sizeW(42),
                  height: AppSizes.sizeH(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              SizedBox(height: AppSizes.sizeH(16)),
              Text(
                "Personal Info",
                style: TextStyle(
                  color: const Color(0xFF141414),
                  fontSize: AppSizes.fontSize(18),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: AppSizes.sizeH(20)),
              CustomTextFormField(
                controller: usernameController,
                title: "User Name",
                hintText: "Enter your name",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter User Name';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSizes.sizeH(16)),
              CustomTextFormField(
                controller: emailController,
                title: "Email",
                hintText: "Enter your email",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!regex.hasMatch(value.trim())) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSizes.sizeH(24)),
              SizedBox(
                width: double.infinity,
                height: AppSizes.sizeH(48),
                child: ElevatedButton(
                  onPressed: _saveUserData,
                  child: const Text("Save Changes"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
