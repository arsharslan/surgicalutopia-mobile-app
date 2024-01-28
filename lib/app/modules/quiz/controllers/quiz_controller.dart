import 'dart:async';

import 'package:get/get.dart';
import 'package:surgicalutopia/app/data/models/question_model.dart';
import 'package:surgicalutopia/app/data/models/section_model.dart';
import 'package:surgicalutopia/app/data/models/subject_model.dart';
import 'package:surgicalutopia/app/data/providers/question_provider.dart';
import 'package:surgicalutopia/app/modules/quiz_result/controllers/quiz_result_controller.dart';
import 'package:surgicalutopia/app/routes/app_pages.dart';
import 'package:surgicalutopia/main.dart';

class QuizController extends GetxController {
  QuizArguments? args;
  RxBool isLoading = false.obs;
  RxList<Question> questions = RxList.empty();

  RxInt currentQuestionIndex = RxInt(0);

  late Timer timer;
  RxnInt timeRemaining = RxnInt();

  @override
  void onInit() {
    if (Get.arguments is QuizArguments?) {
      args = Get.arguments;
    }
    instantiate();
    super.onInit();
  }

  Future<void> instantiate() async {
    isLoading.value = true;
    questions.value = (await getIt<QuestionProvider>().getQuestion(
            sectionId: args?.sectionId,
            subjectId: args?.subjectId)) ??
        [];
    isLoading.value = false;
    timeRemaining.value = (args?.section?.timeRequired ?? 0) * 60;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeRemaining.value = (timeRemaining.value ?? 0) - 1;
      if (timeRemaining.value == 0) {
        timer.cancel();
        Get.offAllNamed(Routes.QUIZ_RESULT,
            arguments: QuizResultArguments(questions: questions));
      }
    });
  }

  String getFormattedTimeRemaining() {
    int minutes = (timeRemaining.value ?? 0) ~/ 60;
    int seconds = (timeRemaining.value ?? 0) % 60;
    return "${minutes <= 9 ? "0$minutes" : minutes}:${seconds <= 9 ? "0$seconds" : seconds}";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
}

class QuizArguments {
  final String? sectionId;
  final Section? section;
  final String? subjectId;
  final Subject? subject;

  const QuizArguments(
      {this.sectionId, this.section, this.subjectId, this.subject});
}
