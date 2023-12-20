import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:surgicalutopia/app/routes/app_pages.dart';
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
      Get.offAllNamed(Routes.HOME);
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
