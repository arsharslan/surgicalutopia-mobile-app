import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:surgicalutopia/app/modules/section_detail/controllers/section_detail_controller.dart';
import 'package:surgicalutopia/app/routes/app_pages.dart';
import 'package:surgicalutopia/widgets/firebase_png.dart';
import 'package:surgicalutopia/widgets/firebase_svg.dart';

import '../controllers/subject_detail_controller.dart';

class SubjectDetailView extends GetView<SubjectDetailController> {
  const SubjectDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Center(
                                    child: Text(
                                        controller.subject.value?.name ?? "",
                                        style: Get.textTheme.titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                  ),
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 8,
                                    child: InkWell(
                                        onTap: Get.back,
                                        child: const Icon(
                                            Icons.keyboard_arrow_left,
                                            color: Colors.white)),
                                  )
                                ],
                              ),
                            ),
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
            toolbarHeight: 128,
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(32))),
          ),
          body: controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: controller.sections
                          ?.map((section) => Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                                color: Get
                                                    .theme.colorScheme.primary
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: section.svgPath != null
                                                ? FirebaseSvg(
                                                    section.svgPath!,
                                                  )
                                                : section.pngPath != null
                                                    ? FirebasePng(
                                                        section.pngPath!,
                                                      )
                                                    : const SizedBox(),
                                          ),
                                        ),
                                      ),
                                      18.horizontalSpace,
                                      Expanded(
                                        flex: 3,
                                        child: Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(section.name ?? "",
                                                    style: Get
                                                        .textTheme.titleMedium
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/document.svg",
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                    4.horizontalSpace,
                                                    Text(
                                                        "${section.numberOfQuestions} Question",
                                                        style: Get.textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Color(
                                                                    0xFF999999)))
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/time.svg",
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                    4.horizontalSpace,
                                                    Text(
                                                        "${section.timeRequired} Minutes",
                                                        style: Get.textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Color(
                                                                    0xFF999999)))
                                                  ],
                                                )
                                              ],
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: InkWell(
                                                onTap: () {
                                                  Get.toNamed(
                                                      Routes.SECTION_DETAIL,
                                                      arguments:
                                                          SectionDetailArguments(
                                                              sectionId:
                                                                  section.sId,
                                                              section: section,
                                                              subjectId:
                                                                  controller
                                                                      .subject
                                                                      .value
                                                                      ?.sId,
                                                              subject:
                                                                  controller
                                                                      .subject
                                                                      .value));
                                                },
                                                child: Row(
                                                  children: [
                                                    Text("Start",
                                                        style: Get.textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Get
                                                                    .theme
                                                                    .colorScheme
                                                                    .secondary)),
                                                    Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        color: Get
                                                            .theme
                                                            .colorScheme
                                                            .secondary)
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                          .toList() ??
                      []));
    });
  }
}
