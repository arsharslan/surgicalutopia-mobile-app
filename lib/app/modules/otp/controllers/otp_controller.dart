import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:surgicalutopia/app/data/models/user_model.dart';
import 'package:surgicalutopia/app/data/providers/user_provider.dart';
import 'package:surgicalutopia/app/routes/app_pages.dart';
import 'package:surgicalutopia/main.dart';
import 'package:surgicalutopia/utils/shared_preferences.dart';
import 'package:surgicalutopia/utils/toast/toast_extension.dart';

class OtpController extends GetxController {
  OtpArguments? args;
  TextEditingController otp = TextEditingController();

  FToast fToast = FToast();
  final parentKey = GlobalKey();

  RxBool isVerifying = false.obs;

  @override
  void onInit() {
    if (Get.arguments is OtpArguments?) {
      args = Get.arguments;
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fToast.init(parentKey.currentContext!);
  }

  @override
  void onClose() {
    super.onClose();
  }

  verify() async {
    try {
      isVerifying.value = true;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: args?.verificationId ?? "", smsCode: otp.text);
      UserCredential userCred =
          await FirebaseAuth.instance.signInWithCredential(credential);
      Response<CustomUser?> response = await getIt<UserProvider>().findUser();
      if (response.statusCode == 404) {
        Get.offAllNamed(Routes.ONBOARDING);
        return;
        
      } else if (response.statusCode == 200) {
        Get.offAllNamed(Routes.HOME);
        await PreferencesHelper.instance
            .setMongoUserId(response.body?.id ?? "");
      }
    } catch (e) {
      fToast.safeShowToast(child: errorToast("Authentication Failed"));
    } finally {
      isVerifying.value = false;
    }
  }
}

class OtpArguments {
  final String? verificationId;
  final String? phoneNumber;

  const OtpArguments({this.phoneNumber, this.verificationId});
}
