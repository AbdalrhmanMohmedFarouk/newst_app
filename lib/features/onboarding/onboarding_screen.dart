import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:newst_app/core/datasource/preferences_manger.dart';
import 'package:newst_app/features/auth/login_screen.dart';
import 'package:newst_app/features/onboarding/controller/onboarding_controller.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'models/onboarding_model.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  void _onFinish(BuildContext context)async{
   await PreferencesManger().setBool("onboarding_complete", true);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => OnboardingController(),
      builder: (context, child) {
        final controller = context.read<OnboardingController>();
        return Scaffold(
          appBar: AppBar(
            actions: [
              Consumer<OnboardingController>(
                builder:
                    (
                      BuildContext context,
                      OnboardingController value,
                      Widget? child,
                    ) {
                      return value.isLastPage
                          ? SizedBox()
                          : TextButton(
                              onPressed: () {
                                _onFinish(context);
                              },
                              child: Text(
                                'Skip',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize:  AppSizes.fontSize(16),
                                ),
                              ),
                            );
                    },
              ),
            ],
          ),
          body: Padding(
            padding:  EdgeInsets.symmetric(vertical:  AppSizes.sizeH(30), horizontal:  AppSizes.sizeW(16)),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: (index) {
                      context.read<OnboardingController>().onPageChange(index);
                    },
                    itemCount: OnboardingModel.onboardingList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final model = OnboardingModel.onboardingList[index];
                      return Column(
                        children: [
                          Image.asset(model.image),
                          SizedBox(height:  AppSizes.sizeH(24)),
                          Text(
                            model.title,
                            style: TextStyle(
                              color: Color(0XFF4E4B66),
                              fontSize:  AppSizes.fontSize(20),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height:  AppSizes.sizeH(12)),
                          Text(
                            model.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0XFF6E7191),
                              fontSize:  AppSizes.fontSize(16),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                        ],
                      );
                    },
                  ),
                ),
                Consumer<OnboardingController>(
                  builder: (context, OnboardingController value, child) {
                    return SmoothPageIndicator(
                      controller: value.pageController,
                      count: 3,
                      effect: WormEffect(activeDotColor: Color(0xFFC53030)),
                    );
                  },
                ),
                SizedBox(height:  AppSizes.sizeH(112)),
                Consumer<OnboardingController>(
                  builder:
                      (
                        BuildContext context,
                        OnboardingController value,
                        Widget? child,
                      ) {
                        return ElevatedButton(
                          onPressed: () {
                            if (!value.isLastPage) {
                              controller.pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }else{
                              _onFinish(context);
                            }
                          },
                          child: value.isLastPage
                              ? Text("Get Started")
                              : Text('Next'),
                        );
                      },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
