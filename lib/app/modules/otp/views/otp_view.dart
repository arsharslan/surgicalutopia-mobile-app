import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:surgicalutopia/widgets/app_bar/app_bar.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.parentKey,
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        flexibleSpace: Stack(
          children: [
            const CustomAppBar(),
            Positioned(
                bottom: 36,
                left: 0,
                right: 0,
                child: SvgPicture.asset("assets/images/otp.svg"))
          ],
        ),
        toolbarHeight: 260,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32))),
      ),
      body: Obx(() {
        return Center(
            child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            Center(
              child: Text("Verification",
                  style: Get.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            20.verticalSpace,
            Center(
              child: Text(
                "Enter OTP sent to your mobile number\n${controller.args?.phoneNumber}",
                textAlign: TextAlign.center,
              ),
            ),
            20.verticalSpace,
            Pinput(
              controller: controller.otp,
              length: 6,
              onCompleted: (_) {
                controller.verify();
              },
            ),
            30.verticalSpace,
            controller.isVerifying.value
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  )
                : FilledButton(
                    onPressed: controller.verify,
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text("Verify OTP"),
                    )),
            16.verticalSpace,
            Center(
              child: Text("Resend",
                  style: Get.textTheme.bodyMedium?.copyWith(
                      color: Get.theme.colorScheme.primary,
                      decoration: TextDecoration.underline)),
            )
          ],
        ));
      }),
    );
  }
}
