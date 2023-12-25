import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:surgicalutopia/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:surgicalutopia/app/routes/app_pages.dart';

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
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 48, left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Column(
                                    children: [
                                      Center(
                                        child: Text(
                                            controller.subject?.name ?? "",
                                            style: Get.textTheme.titleMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: InkWell(
                                        onTap: Get.back,
                                        child: const Icon(
                                            Icons.keyboard_arrow_left,
                                            color: Colors.white)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Text(controller.section?.name ?? "",
                                  style: Get.textTheme.titleLarge
                                      ?.copyWith(color: Colors.white)),
                              const SizedBox(height: 4),
                              Text(
                                  "Total ${controller.section?.numberOfQuestions} Questions",
                                  style: Get.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white))
                            ],
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
          toolbarHeight: 200,
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(32))),
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Brief explanation about this quiz",
                        style: Get.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    ...[
                      {
                        "imagePath": "assets/icons/document.svg",
                        "heading":
                            "${controller.section?.numberOfQuestions} Questions",
                        "description": "1 point for a correct answer"
                      },
                      {
                        "imagePath": "assets/icons/time.svg",
                        "heading":
                            "${controller.section?.timeRequired} Questions",
                        "description": "Total duration of the quiz"
                      },
                      {
                        "imagePath": "assets/icons/favorite.svg",
                        "heading": "Instant Result",
                        "description": "Submit the test and get instant results"
                      },
                    ].map((e) => Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Get.theme.colorScheme.primary,
                                  shape: BoxShape.circle),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    e['imagePath'] ?? "",
                                    color: Colors.white,
                                    height: 24,
                                    width: 24,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e['heading'] ?? "",
                                    style: Get.textTheme.bodyLarge),
                                Text(e['description'] ?? "",
                                    style: Get.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.grey)),
                              ],
                            )
                          ],
                        )),
                    const SizedBox(height: 16),
                    Text(
                        "Please read the text below carefully so you can understand it",
                        style: Get.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    ...[
                      "1 point awarded for a correct answer and no marks for a incorrect answer",
                      "Tap on options to select the correct answer",
                      "Tap on the bookmark icon to save interesting questions",
                      "Click submit if you are sure you want to complete all the quizzes"
                    ].map((e) => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 4,
                              width: 4,
                              margin: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Text(e))
                          ],
                        )),
                    const Spacer(),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                            child: FilledButton(
                                onPressed: () {
                                  Get.toNamed(Routes.QUIZ,
                                      arguments: QuizArguments(
                                          sectionId: controller.args?.sectionId,
                                          section: controller.args?.section,
                                          subject: controller.args?.subject,
                                          subjectId:
                                              controller.args?.subjectId));
                                },
                                child: Text("Start Quiz"))),
                      ],
                    ),
                    const SizedBox(height: 16)
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
