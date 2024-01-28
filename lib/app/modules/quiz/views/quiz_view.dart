import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:surgicalutopia/app/modules/quiz_result/controllers/quiz_result_controller.dart';
import 'package:surgicalutopia/app/routes/app_pages.dart';
import 'package:surgicalutopia/widgets/firebase_png.dart';

import '../controllers/quiz_controller.dart';
import 'package:collection/collection.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({Key? key}) : super(key: key);
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
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Center(
                                  child: Text(
                                      controller.args?.section?.name ?? "",
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
                                ),
                                Positioned(
                                    top: 0,
                                    bottom: 0,
                                    right: 8,
                                    child: PopupMenuButton(
                                      child: const Icon(
                                        Icons.more_vert_outlined,
                                        color: Colors.white,
                                      ),
                                      onSelected: (item) {},
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry>[
                                        PopupMenuItem(
                                          child: InkWell(
                                              onTap: () {
                                                Get.offAllNamed(
                                                    Routes.QUIZ_RESULT,
                                                    arguments:
                                                        QuizResultArguments(
                                                            questions: controller
                                                                .questions));
                                              },
                                              child: Text("Submit")),
                                        ),
                                      ],
                                    ))
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
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(32))),
        ),
        body: Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                    "Question ${controller.currentQuestionIndex.value + 1}/${controller.questions?.length}",
                                    style: Get.textTheme.titleSmall),
                                const SizedBox(height: 16),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(64),
                                      color: (controller.timeRemaining.value ??
                                                  0) <=
                                              10
                                          ? Colors.red.withOpacity(0.2)
                                          : Get.theme.colorScheme.primary
                                              .withOpacity(0.2)),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/icons/time.svg",
                                          color: (controller.timeRemaining
                                                          .value ??
                                                      0) <=
                                                  10
                                              ? Colors.red
                                              : Get.theme.colorScheme.primary),
                                      const SizedBox(width: 4),
                                      Text(
                                          controller
                                              .getFormattedTimeRemaining(),
                                          style: Get.textTheme.bodyMedium
                                              ?.copyWith(
                                                  color: (controller
                                                                  .timeRemaining
                                                                  .value ??
                                                              0) <=
                                                          10
                                                      ? Colors.red
                                                      : Get.theme.colorScheme
                                                          .primary))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 64,
                              child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: controller.questions
                                      .mapIndexed((index, question) => Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    controller
                                                        .currentQuestionIndex
                                                        .value = index;
                                                  },
                                                  child: Container(
                                                    height: 36,
                                                    width: 36,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: index ==
                                                                controller
                                                                    .currentQuestionIndex
                                                                    .value
                                                            ? Get
                                                                .theme
                                                                .colorScheme
                                                                .secondary
                                                            : question.choosedOption !=
                                                                    null
                                                                ? controller
                                                                            .args
                                                                            ?.section
                                                                            ?.showResultsEarly ==
                                                                        true
                                                                    ? question.correctOption ==
                                                                            question
                                                                                .choosedOption
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .red
                                                                    : Get
                                                                        .theme
                                                                        .colorScheme
                                                                        .tertiary
                                                                : Colors.grey
                                                                    .shade400),
                                                    child: Text("${index + 1}",
                                                        style: Get.textTheme
                                                            .titleMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .white)),
                                                  ),
                                                ),
                                                Divider(
                                                    color: index ==
                                                            controller
                                                                .currentQuestionIndex
                                                                .value
                                                        ? Get.theme.colorScheme
                                                            .secondary
                                                        : question.choosedOption !=
                                                                null
                                                            ? Get
                                                                .theme
                                                                .colorScheme
                                                                .tertiary
                                                            : Colors
                                                                .grey.shade400)
                                              ],
                                            ),
                                          ))
                                      .toList()),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                      controller
                                              .questions[controller
                                                  .currentQuestionIndex.value]
                                              .question ??
                                          "",
                                      style: Get.textTheme.titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                    controller
                                            .questions[controller
                                                .currentQuestionIndex.value]
                                            .reference ??
                                        "",
                                    style: Get.textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey))
                              ],
                            ),
                            if (controller
                                    .questions[
                                        controller.currentQuestionIndex.value]
                                    .imagePath !=
                                null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: FirebasePng(controller
                                        .questions[controller
                                            .currentQuestionIndex.value]
                                        .imagePath ??
                                    ""),
                              ),
                            const SizedBox(height: 16),
                            ...<MapEntry<String, String?>>[
                              MapEntry(
                                  "A",
                                  controller
                                      .questions[
                                          controller.currentQuestionIndex.value]
                                      .optionA),
                              MapEntry(
                                  "B",
                                  controller
                                      .questions[
                                          controller.currentQuestionIndex.value]
                                      .optionB),
                              MapEntry(
                                  "C",
                                  controller
                                      .questions[
                                          controller.currentQuestionIndex.value]
                                      .optionC),
                              MapEntry(
                                  "D",
                                  controller
                                      .questions[
                                          controller.currentQuestionIndex.value]
                                      .optionD),
                            ].map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: InkWell(
                                  onTap: controller
                                              .questions[controller
                                                  .currentQuestionIndex.value]
                                              .choosedOption !=
                                          null
                                      ? null
                                      : () {
                                          controller
                                              .questions[controller
                                                  .currentQuestionIndex.value]
                                              .choosedOption = e.key;
                                          controller.questions.refresh();
                                        },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: controller
                                                        .questions[controller
                                                            .currentQuestionIndex
                                                            .value]
                                                        .choosedOption ==
                                                    e.key
                                                ? controller.args?.section
                                                            ?.showResultsEarly ==
                                                        true
                                                    ? controller
                                                                .questions[
                                                                    controller
                                                                        .currentQuestionIndex
                                                                        .value]
                                                                .choosedOption ==
                                                            controller
                                                                .questions[
                                                                    controller
                                                                        .currentQuestionIndex
                                                                        .value]
                                                                .correctOption
                                                        ? Colors.green
                                                        : Colors.red
                                                    : Get.theme.colorScheme
                                                        .secondary
                                                : Colors.grey.shade400,
                                            shape: BoxShape.circle),
                                        child: Text(e.key,
                                            style: Get.textTheme.titleSmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(e.value ?? "",
                                          style: Get.textTheme.bodyMedium?.copyWith(
                                              color: controller
                                                          .questions[controller
                                                              .currentQuestionIndex
                                                              .value]
                                                          .choosedOption ==
                                                      e.key
                                                  ? Get.theme.colorScheme
                                                      .secondary
                                                  : Colors.black)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (controller.args?.section?.showResultsEarly ==
                                    true &&
                                controller
                                        .questions[controller
                                            .currentQuestionIndex.value]
                                        .choosedOption !=
                                    null &&
                                controller
                                        .questions[controller
                                            .currentQuestionIndex.value]
                                        .explanation !=
                                    null) ...[
                              Text("Explanation :",
                                  style: Get.textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              Text(controller
                                      .questions[
                                          controller.currentQuestionIndex.value]
                                      .explanation ??
                                  "")
                            ],
                            const Spacer(),
                            Row(
                              children: [
                                Expanded(
                                    child: OutlinedButton(
                                        onPressed: () {
                                          if (controller
                                                  .currentQuestionIndex.value >
                                              0) {
                                            controller.currentQuestionIndex
                                                .value = controller
                                                    .currentQuestionIndex
                                                    .value -
                                                1;
                                          }
                                        },
                                        child: const Text("Previous"))),
                                8.horizontalSpace,
                                Expanded(
                                  child: FilledButton(
                                      onPressed: () {
                                        if ((controller.currentQuestionIndex
                                                    .value +
                                                1) ==
                                            controller.questions.length) {
                                          Get.offAllNamed(Routes.QUIZ_RESULT,
                                              arguments: QuizResultArguments(
                                                  questions:
                                                      controller.questions));
                                        } else {
                                          controller.currentQuestionIndex
                                              .value = controller
                                                  .currentQuestionIndex.value +
                                              1;
                                        }
                                      },
                                      child: Text((controller
                                                      .currentQuestionIndex
                                                      .value +
                                                  1) ==
                                              controller.questions.length
                                          ? "Submit"
                                          : "Next")),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16)
                          ],
                        ),
                      ),
                    )
                  ],
                );
        }));
  }
}
