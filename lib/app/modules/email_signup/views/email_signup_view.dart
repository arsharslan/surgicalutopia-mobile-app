import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:surgicalutopia/widgets/app_bar/app_bar.dart';
import 'package:surgicalutopia/widgets/custom_text_form_field.dart';

import '../controllers/email_signup_controller.dart';

class EmailSignupView extends GetView<EmailSignupController> {
  const EmailSignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MediaQuery.of(context).viewInsets.bottom == 0
            ? AppBar(
                backgroundColor: Get.theme.scaffoldBackgroundColor,
                flexibleSpace: Stack(
                  children: [
                    const CustomAppBar(),
                    Positioned(
                        bottom: 36,
                        left: 0,
                        right: 0,
                        child:
                            SvgPicture.asset("assets/images/phone_number.svg"))
                  ],
                ),
                toolbarHeight: 260,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(32))),
              )
            : AppBar(
                backgroundColor: Get.theme.colorScheme.primary,
                elevation: 0,
                foregroundColor: Colors.white,
                title: Text("Sign Up"),
              ),
        body: Obx(() {
          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                        key: controller.formState,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Sign Up",
                                style: Get.textTheme.headlineMedium
                                    ?.copyWith(color: Colors.black)),
                            const Spacer(flex: 1),
                            CustomTextFormField(
                              hintText: "Email",
                              controller: controller.emailController,
                              validator: (value) {
                                if (value == null || value.length < 3) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                            ),
                            16.verticalSpace,
                            CustomTextFormField(
                              hintText: "Password",
                              controller: controller.passwordController,
                              validator: (value) {
                                if (value == null || value.length < 6) {
                                  return "Please enter a valid password";
                                }
                                return null;
                              },
                            ),
                            24.verticalSpace,
                            FilledButton(
                                onPressed: controller.loginEmail,
                                child: controller.isLoggingIn.value
                                    ? const SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ))
                                    : const Text("Sign Up")),
                            const Spacer(flex: 3)
                          ],
                        )),
                  ))
            ],
          );
        }));
  }
}
