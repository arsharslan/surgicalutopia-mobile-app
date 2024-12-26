import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgicalutopia/app/data/models/user_model.dart';
import 'package:surgicalutopia/app/data/providers/user_provider.dart';
import 'package:surgicalutopia/app/routes/app_pages.dart';
import 'package:surgicalutopia/main.dart';
import 'package:surgicalutopia/utils/shared_preferences.dart';

class EmailLoginController extends GetxController {
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
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Response<CustomUser?> response = await getIt<UserProvider>().findUser();
      if (response.statusCode == 404) {
        Get.offAllNamed(Routes.ONBOARDING);
        return;
      } else if (response.statusCode == 200) {
        Get.offAllNamed(Routes.HOME);
        await PreferencesHelper.instance
            .setMongoUserId(response.body?.id ?? "");
      }
    } on FirebaseException catch (e) {
    } catch (e) {}
    isLoggingIn.value = false;
  }
}
