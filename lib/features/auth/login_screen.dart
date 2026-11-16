import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:newst_app/core/datasource/local_data/preferences_manger.dart';
import 'package:newst_app/core/datasource/local_data/user_repository.dart';
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

  String? errorMessage;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    final String? error = UserRepository().login(
      emailController.text.trim(),
      passwordController.text,
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

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const MainScreen();
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_image.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: AppSizes.sizeH(45),
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
                  controller: emailController,
                  title: "Email",
                  hintText: "example@gmail.com",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }

                    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

                    if (!regex.hasMatch(value.trim())) {
                      return 'Enter a valid email';
                    }

                    return null;
                  },
                ),
                SizedBox(height: AppSizes.sizeH(16)),
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
                if (errorMessage != null)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: AppSizes.sizeW(8)),
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                SizedBox(height: AppSizes.sizeH(20)),
                Center(
                  child: SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_form.currentState?.validate() ?? false) {
                                login();
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
                          : const Text("Sign In"),
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.sizeH(24)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account ?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const RegisterScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style:
                            TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
