import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgicalutopia/app/data/models/question_model.dart';

class QuizResultController extends GetxController
    with GetSingleTickerProviderStateMixin {
  QuizResultArguments? args;
  late AnimationController animationController;

  @override
  void onInit() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    if (Get.arguments is QuizResultArguments?) {
      args = Get.arguments;
    }
    super.onInit();
    animationController.forward();
  }

  double get correctPercentage {
    int correctAttempts = args?.questions
            ?.where(
                (question) => question.correctOption == question.choosedOption)
            .length ??
        0;
    return correctAttempts / (args?.questions?.length ?? 1);
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

class QuizResultArguments {
  final List<Question>? questions;

  const QuizResultArguments({this.questions});
}
