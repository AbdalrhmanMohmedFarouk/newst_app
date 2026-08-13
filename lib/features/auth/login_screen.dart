import 'package:flutter/material.dart';
import 'package:newst_app/core/widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset("assets/images/logo.png", height: 45)),
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
              ),
              // TextFormField(
              //   controller: emailController,
              //   decoration: InputDecoration(
              //     label: Text(
              //       "Email",
              //       style: TextStyle(
              //         color: Color(0XFF141414),
              //         fontWeight: FontWeight.w400,
              //         fontSize: 16,
              //       ),
              //     ),
              //     hint: Text(
              //       "dev@gmail.com",
              //       style: TextStyle(
              //         color: Color(0XFF363636),
              //         fontWeight: FontWeight.w400,
              //         fontSize: 16,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: passwordController,
                title: 'Password',
                hintText: '*************',
                obscureText: true,
              ),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
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
                    onPressed: () {},
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
    );
  }
}
