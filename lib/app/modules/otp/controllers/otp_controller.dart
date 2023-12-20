import 'package:get/get.dart';

class OtpController extends GetxController {
  OtpArguments? args;

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
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class OtpArguments {
  final String? verificationId;
  final String? phoneNumber;

  const OtpArguments({this.phoneNumber, this.verificationId});
}
