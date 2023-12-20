import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:surgicalutopia/app/modules/otp/controllers/otp_controller.dart';
import 'package:surgicalutopia/app/routes/app_pages.dart';
import 'package:surgicalutopia/utils/toast/toast_extension.dart';

class PhoneNumberController extends GetxController {
  RxString selectedCountryCode = "+91".obs;
  String? verificationId;
  RxBool isVerifying = false.obs;
  TextEditingController phoneController = TextEditingController();
  FToast fToast = FToast();
  final parentKey = GlobalKey();

  @override
  void onInit() {
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

  sendOTP() async {
    // isOTPSent.value = true;
    // isVerifying.value = false;
    // update();
    isVerifying.value = true;
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${selectedCountryCode.value}${phoneController.text}",
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          isVerifying.value = false;
        },
        codeSent: (verificationId, forceResendingToken) {
          this.verificationId = verificationId;
          fToast.safeShowToast(child: successToast("OTP Sent"));
          Get.toNamed(Routes.OTP,
              arguments: OtpArguments(
                  phoneNumber:
                      "${selectedCountryCode.value}${phoneController.text}",
                  verificationId: this.verificationId));
          isVerifying.value = false;
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }
}
