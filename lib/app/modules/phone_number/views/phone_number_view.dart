import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:surgicalutopia/widgets/app_bar/app_bar.dart';

import '../controllers/phone_number_controller.dart';

class PhoneNumberView extends GetView<PhoneNumberController> {
  const PhoneNumberView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: controller.parentKey,
        appBar: AppBar(
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          flexibleSpace: Stack(
            children: [
              CustomAppBar(),
              Positioned(
                  bottom: 36,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset("assets/images/phone_number.svg"))
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
                  child: Text("Hey, Hello 👋",
                      style: Get.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 12),
                const Text(
                    "Please enter your mobile number to enjoy using our App",
                    textAlign: TextAlign.center),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.phoneController,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Mobile Number",
                      prefixIconConstraints: BoxConstraints(maxWidth: 80),
                      prefixIcon: Container(
                        padding: const EdgeInsets.only(left: 12),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              onClosed: () {},
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                print('Select country: ${country.displayName}');
                                controller.selectedCountryCode.value =
                                    "+${country.phoneCode}";
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(controller.selectedCountryCode.value,
                                  style: Get.textTheme.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              const Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        ),
                      ),
                      fillColor: Colors.grey.shade200,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.all(Radius.circular(64))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.all(Radius.circular(64))),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.all(Radius.circular(64)))),
                ),
                const SizedBox(height: 28),
                controller.isVerifying.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                              child: FilledButton(
                                  style: FilledButton.styleFrom(
                                      textStyle: Get.textTheme.titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    controller.sendOTP();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text("Send OTP"),
                                  ))),
                        ],
                      )
              ],
            ),
          );
        }));
  }
}
