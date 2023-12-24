import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/section_detail_controller.dart';

class SectionDetailView extends GetView<SectionDetailController> {
  const SectionDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        flexibleSpace: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(stops: const [
                          0,
                          1,
                          1
                        ], colors: [
                          const Color.fromRGBO(167, 254, 165, 0.60),
                          Get.theme.colorScheme.primary,
                          const Color(0xFF00FF19)
                        ])),
                      ),
                      Positioned(
                        top: -Get.height / 2,
                        bottom: -Get.height / 2,
                        left: -Get.width / 2,
                        child: Container(
                          width: Get.width,
                          height: Get.height,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(52, 168, 83, 0.10)),
                        ),
                      ),
                      Stack(
                        fit: StackFit.expand,
                        children: [
                          Column(
                            children: [
                              Center(
                                child: Text(controller.subject?.name ?? "",
                                    style: Get.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              16.verticalSpace,
                              InkWell(
                                  onTap: Get.back,
                                  child: const Icon(Icons.keyboard_arrow_left,
                                      color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ],
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
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(48))),
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
          ],
        ),
        leading: const SizedBox(),
        toolbarHeight: 256,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32))),
      ),
      body: const Center(
        child: Text(
          'SectionDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
