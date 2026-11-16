import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:newst_app/core/datasource/local_data/preferences_manger.dart';
import 'package:newst_app/core/datasource/local_data/user_repository.dart';
import 'package:newst_app/core/widgets/custom_text_form_field.dart';
import 'package:newst_app/features/main/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  String? errorMessage;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  void register() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    final error = await UserRepository().singUp(
      email: emailController.text.trim(),
      password: passwordController.text,
      name: usernameController.text.trim(),
    );

    if (error != null) {
      if (!mounted) return;
      setState(() {
        errorMessage = error;
        isLoading = false;
      });
      return;
    }

    await PreferencesManger().setBool("is_logged_in", true);

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const MainScreen();
        },
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_image.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.sizeW(16)),
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: AppSizes.sizeH(40),
                      ),
                    ),
                    SizedBox(height: AppSizes.sizeH(40)),
                    Text(
                      "Welcome to Newts",
                      style: TextStyle(
                        color: const Color(0XFF363636),
                        fontWeight: FontWeight.w700,
                        fontSize: AppSizes.fontSize(20),
                      ),
                    ),
                    SizedBox(height: AppSizes.sizeH(24)),
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
                      hintText: "example@gmail.com",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        }

                        final regex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                        if (!regex.hasMatch(value.trim())) {
                          return 'Enter a valid email';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: AppSizes.sizeH(16)),
                    CustomTextFormField(
                      controller: passwordController,
                      title: "Password",
                      hintText: "At least 8 characters",
                      validator: (value) {
                        final passwordRegex = RegExp(
                          r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&*!]).{8,}$',
                        );

                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }

                        if (!passwordRegex.hasMatch(value)) {
                          return 'Password must contain 8+ characters with uppercase, lowercase, number and special char';
                        }

                        return null;
                      },
                      obscureText: true,
                    ),
                    SizedBox(height: AppSizes.sizeH(16)),
                    CustomTextFormField(
                      controller: confirmPasswordController,
                      title: "Confirm Password",
                      hintText: "Re-enter your password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }

                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }

                        return null;
                      },
                      obscureText: true,
                    ),
                    if (errorMessage != null)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppSizes.sizeW(8),
                        ),
                        child: Text(
                          errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    SizedBox(height: AppSizes.sizeH(20)),
                    SizedBox(
                      width: double.infinity,
                      height: AppSizes.sizeH(48),
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  register();
                                }
                              },
                        child: isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Sign Up"),
                      ),
                    ),
                    SizedBox(height: AppSizes.sizeH(24)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have an account ?"),
                        SizedBox(width: AppSizes.sizeW(8)),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
