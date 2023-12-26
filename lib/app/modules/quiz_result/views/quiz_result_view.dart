import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/quiz_result_controller.dart';

class QuizResultView extends GetView<QuizResultController> {
  const QuizResultView({Key? key}) : super(key: key);
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
                            padding: const EdgeInsets.only(top: 24),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Center(
                                  child: Text("Result",
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
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(32))),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: controller.animationController,
                  builder: (context, _) {
                    return SizedBox(
                      height: 100,
                      width: 100,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CircularProgressIndicator(
                              value: (controller.correctPercentage) *
                                  (controller.animationController.value),
                              strokeWidth: 32,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                              backgroundColor: Colors.green.withOpacity(0.15),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              height: 80,
                              width: 80,
                              child: Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(128)),
                                child: Center(
                                    child: Text(
                                        "${(controller.correctPercentage * 100).toStringAsFixed(0)}%",
                                        style: Get.textTheme.titleSmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold))),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
              const SizedBox(height: 32),
              Text("Correct Attempts",
                  style: Get.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ));
  }
}
