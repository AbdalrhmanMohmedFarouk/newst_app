import 'package:flutter/material.dart';
import 'package:newst_app/core/widgets/custom_text_form_field.dart';
import 'package:newst_app/features/auth/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();

  bool isVisible = false;

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset("assets/images/logo.png", height: 45),
                ),
                SizedBox(height: 40),
                Text(
                  "Welcome to Newts",
                  style: TextStyle(
                    color: Color(0XFF363636),
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 24),
                CustomTextFormField(
                  controller: emailController,
                  title: "Email",
                  hintText: "dev@gmail.com",
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

                SizedBox(height: 16),
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
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_form.currentState?.validate() ?? false) {}
                      },
                      child: Text("Sign In"),
                    ),
                  ),
                ),
                SizedBox(height: 24),
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
    );
  }
}
