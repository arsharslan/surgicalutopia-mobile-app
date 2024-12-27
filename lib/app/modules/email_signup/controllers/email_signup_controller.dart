import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgicalutopia/app/routes/app_pages.dart';

class EmailSignupController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoggingIn = false.obs;

  final formState = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> loginEmail() async {
    isLoggingIn.value = true;
    try {
      if (formState.currentState?.validate() != true) {
        isLoggingIn.value = false;
        return;
      }
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Get.offAllNamed(Routes.ONBOARDING);
    } on FirebaseException catch (e) {
    } catch (e) {}
    isLoggingIn.value = false;
  }
}
