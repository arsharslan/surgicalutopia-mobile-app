import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:surgicalutopia/app/modules/leaderboard/views/leaderboard_view.dart';
import 'package:surgicalutopia/app/modules/onboarding/views/onboarding_view.dart';
import 'package:surgicalutopia/app/modules/profile/views/profile_view.dart';
import 'package:surgicalutopia/app/modules/subject_detail/controllers/subject_detail_controller.dart';
import 'package:surgicalutopia/app/routes/app_pages.dart';
import 'package:surgicalutopia/widgets/app_bar/app_bar.dart';
import 'package:surgicalutopia/widgets/firebase_png.dart';
import 'package:surgicalutopia/widgets/firebase_svg.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: [
          1,
        ].contains(controller.currentIndex.value)
            ? AppBar(
                backgroundColor: Get.theme.scaffoldBackgroundColor,
                flexibleSpace: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
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
                    Positioned(
                      top: 0,
                      bottom: 48,
                      left: -Get.width * 0.6,
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(Get.width)),
                            color: const Color.fromRGBO(52, 168, 83, 0.10)),
                      ),
                    ),
                    Positioned(
                        bottom: 64,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Hello",
                                          style: Get.textTheme.titleMedium),
                                      8.verticalSpace,
                                      Text("Let's test your knowledge",
                                          style: Get.textTheme.titleLarge),
                                    ],
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset("assets/images/home.svg")
                                ],
                              ),
                              TextFormField(
                                  // keyboardType: TextInputType.phone,
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      controller.filteredSubjects.value = [];
                                    } else {
                                      controller.filteredSubjects.value =
                                          controller
                                              .allSubjects
                                              .where((p0) =>
                                                  p0
                                                      .name
                                                      ?.toUpperCase()
                                                      .contains(value
                                                          .toUpperCase()) ==
                                                  true)
                                              .toList();
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Search Subject",
                                      hintStyle: Get.textTheme.bodyMedium
                                          ?.copyWith(color: Colors.grey),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Icon(Icons.search,
                                            color:
                                                Get.theme.colorScheme.primary),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(64))))
                            ],
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 32, right: 32, bottom: 2),
                        child: Obx(() {
                          return Text(
                              controller.filteredSubjects.isEmpty
                                  ? "All Subjects"
                                  : "Filtered Subjects",
                              style: Get.textTheme.titleLarge);
                        }),
                      ),
                    )
                  ],
                ),
                toolbarHeight: 256,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(32))),
              )
            : null,
        body: controller.currentIndex.value == 1
            ? controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                        if (controller.filteredSubjects.isNotEmpty) ...[
                          ...controller.filteredSubjects
                              .map((subject) => InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.SUBJECT_DETAIL,
                                          arguments: SubjectDetailArguments(
                                              subject: subject,
                                              subjectId: subject.sId));
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 38,
                                              width: 38,
                                              decoration: BoxDecoration(
                                                  color: Get
                                                      .theme.colorScheme.primary
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  subject.svgPath != null
                                                      ? FirebaseSvg(
                                                          subject.svgPath!,
                                                          height: 24,
                                                          width: 24,
                                                        )
                                                      : subject.pngPath != null
                                                          ? FirebasePng(
                                                              subject.pngPath!,
                                                              height: 24,
                                                              width: 24,
                                                            )
                                                          : const SizedBox(),
                                                ],
                                              ),
                                            ),
                                            18.horizontalSpace,
                                            Text(subject.name ?? "",
                                                style: Get.textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                          Divider(color: Colors.grey.shade400),
                        ],
                        ...controller.allSubjects.map((subject) => InkWell(
                              onTap: () {
                                Get.toNamed(Routes.SUBJECT_DETAIL,
                                    arguments: SubjectDetailArguments(
                                        subject: subject,
                                        subjectId: subject.sId));
                              },
                              child: Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 38,
                                        width: 38,
                                        decoration: BoxDecoration(
                                            color: Get.theme.colorScheme.primary
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            subject.svgPath != null
                                                ? FirebaseSvg(
                                                    subject.svgPath!,
                                                    height: 24,
                                                    width: 24,
                                                  )
                                                : subject.pngPath != null
                                                    ? FirebasePng(
                                                        subject.pngPath!,
                                                        height: 24,
                                                        width: 24,
                                                      )
                                                    : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                      18.horizontalSpace,
                                      Text(subject.name ?? "",
                                          style: Get.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      ])
            : controller.currentIndex.value == 2
                ? const LeaderboardView()
                : const ProfileView(),
        bottomNavigationBar: CurvedNavigationBar(
          height: 48,
          backgroundColor: const Color.fromRGBO(167, 254, 165, 0.4),
          items: <Widget>[
            Icon(Icons.subject, size: 30),
            SvgPicture.asset(
              "assets/icons/crown.svg",
              height: 24,
              width: 24,
            ),
            Icon(Icons.account_circle, size: 30),
          ],
          onTap: (index) {
            controller.currentIndex.value = index + 1;
          },
        ),
      );
    });
  }
}
