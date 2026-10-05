import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:newst_app/core/datasource/preferences_manger.dart';
import 'package:newst_app/core/widgets/custom_text_form_field.dart';
import 'package:newst_app/features/auth/register_screen.dart';

import 'package:newst_app/features/main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey();

  bool isVisible = false;
  String? errorMessage;
  bool isLoading = false;

  void login() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    final savedEmail = PreferencesManger().getString("user_email");
    final savedPassword = PreferencesManger().getString("user_password");

    if (savedEmail == null || savedPassword == null) {
      setState(() {
        errorMessage = "No Account Found Please Register First";
        isLoading=false;
      });
      return;
    }
    if(savedEmail != emailController.text || savedPassword != passwordController.text){
      setState(() {
        errorMessage = "Incorrect Email or Password";
        isLoading=false;
      });
      return;
    }

    setState(() {
      errorMessage = null ;
      isLoading=false;
    });

    await PreferencesManger().setBool("is_logged_in", true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return MainScreen();
        },
      ),
    );
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
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset("assets/images/logo.png", height: AppSizes.sizeH(45)),
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
                      controller: emailController,
                      title: "Email",
                      hintText: "dev@gmail.com",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }

                        final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

                        if (!regex.hasMatch(value)) {
                          return 'Enter a valid email';
                        }

                        return null;
                      },
                    ),

                    SizedBox(height:  AppSizes.sizeH(16)),
                    CustomTextFormField(
                      controller: passwordController,
                      title: 'Password',
                      hintText: '*************',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }

                        return null;
                      },
                      obscureText: true,
                    ),
                    if(errorMessage != null)
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical:  AppSizes.sizeW(8)),
                        child: Text(errorMessage!,style: TextStyle(color: Colors.red),),
                      ),
                    SizedBox(height:  AppSizes.sizeH(20)),
                    Center(
                      child: SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_form.currentState?.validate() ?? false) {
                              login();
                            }
                          },
                          child:isLoading ? CircularProgressIndicator(): Text("Sign In"),
                        ),
                      ),
                    ),
                    SizedBox(height:  AppSizes.sizeH(24)),
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text("Don’t have an account ?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return RegisterScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
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
