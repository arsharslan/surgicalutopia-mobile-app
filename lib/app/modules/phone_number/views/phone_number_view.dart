import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

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
              Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(stops: const [
                                0,
                                1,
                                1
                              ], colors: [
                                const Color.fromRGBO(167, 254, 165, 0.60),
                                Get.theme.colorScheme.primary,
                                const Color(0xFF00FF19)
                              ]),
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(48))),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(stops: const [
                                0,
                                1,
                                1
                              ], colors: [
                                const Color.fromRGBO(167, 254, 165, 0.60),
                                Get.theme.colorScheme.primary,
                                const Color(0xFF00FF19)
                              ]),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Get.theme.scaffoldBackgroundColor,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(48))),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(29, 110, 51, 0.098)),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(48)),
                                    color: Get.theme.scaffoldBackgroundColor),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Positioned(
                    top: 0,
                    bottom: 48,
                    left: -Get.width * 0.4,
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(Get.width)),
                          color: const Color.fromRGBO(52, 168, 83, 0.10)),
                    ),
                  )
                ],
              ),
              Positioned(
                  bottom: 38,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset("assets/images/phone_number.svg"))
            ],
          ),
          toolbarHeight: 300,
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
                Row(
                  children: [
                    InkWell(
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
                    const SizedBox(width: 8),
                    Expanded(
                        child: TextFormField(
                      controller: controller.phoneController,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "Mobile Number",
                          fillColor: Colors.grey.shade200,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                    )),
                  ],
                ),
                const SizedBox(height: 28),
                controller.isVerifying.value
                    ? CircularProgressIndicator()
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
                                  child: Text("Send OTP"))),
                        ],
                      )
              ],
            ),
          );
        }));
  }
}
