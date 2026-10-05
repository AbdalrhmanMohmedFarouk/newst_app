import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:newst_app/core/datasource/preferences_manger.dart';
import 'package:newst_app/core/widgets/custom_text_form_field.dart';


import '../main/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

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

  void register() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    final savedEmail = PreferencesManger().getString("user_email");
    if (savedEmail != null && savedEmail == emailController.text.trim() ) {
      setState(() {
        errorMessage = "User Already Registered";
        isLoading = false;
      });
    } else {
      await PreferencesManger().setString("user_email", emailController.text);
      await PreferencesManger().setString("username", usernameController.text);
      await PreferencesManger().setString(
        "user_password",
        passwordController.text,
      );
      await PreferencesManger().setBool("is_logged_in", true);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainScreen();
          },
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_image.png"),
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.all( AppSizes.sizeW(16)),
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset("assets/images/logo.png", height:  AppSizes.sizeH(40)),
                    ),
                    SizedBox(height:  AppSizes.sizeH(40)),
                    Text(
                      "Welcome to Newts",
                      style: TextStyle(
                        color: Color(0XFF363636),
                        fontWeight: FontWeight.w700,
                        fontSize:  AppSizes.fontSize(20),
                      ),
                    ),
                    SizedBox(height:  AppSizes.sizeH(24)),
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
                    ),CustomTextFormField(
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
                    SizedBox(height:  AppSizes.sizeH(16)),
                    CustomTextFormField(
                      controller: passwordController,
                      title: "Password",
                      hintText: "*************",
                      validator: (value) {
                        final passwordRegex = RegExp(
                          r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&*!]).{8,}$',
                        );
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }

                        if (!passwordRegex.hasMatch(value)) {
                          return 'Password must contain 8 characters, uppercase, lowercase, number and special character';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    SizedBox(height:  AppSizes.sizeH(16)),
                    CustomTextFormField(
                      controller: confirmPasswordController,
                      title: "Confirm Password",
                      hintText: "*************",
                      validator: (value) {
                        final passwordRegex = RegExp(
                          r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&*!]).{8,}$',
                        );
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }

                        if (!passwordRegex.hasMatch(value)) {
                          return 'Password must contain 8 characters, uppercase, lowercase, number and special character';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    if (errorMessage != null)
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical:  AppSizes.sizeW(8)),
                        child: Text(
                          errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    SizedBox(height:  AppSizes.sizeH(20)),
                    SizedBox(
                      width: double.infinity,
                      height:  AppSizes.sizeH(48),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            register();
                          }
                        },
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text("Sign Up"),
                      ),
                    ),
                    SizedBox(height:  AppSizes.sizeH(24)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Have an account ?"),
                        SizedBox(width:  AppSizes.sizeW(8)),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(color: Theme.of(context).primaryColor),
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
