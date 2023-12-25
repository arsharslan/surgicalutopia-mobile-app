import 'package:get/get.dart';
import 'package:surgicalutopia/app/data/models/question_model.dart';
import 'package:surgicalutopia/app/data/models/section_model.dart';
import 'package:surgicalutopia/app/data/models/subject_model.dart';
import 'package:surgicalutopia/app/data/providers/question_provider.dart';
import 'package:surgicalutopia/main.dart';

class QuizController extends GetxController {
  QuizArguments? args;
  RxBool isLoading = false.obs;
  List<Question>? questions = [];

  RxInt currentQuestionIndex = RxInt(0);

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
    questions = await getIt<QuestionProvider>()
        .getQuestion(sectionId: args?.sectionId, subjectId: args?.subjectId);
    isLoading.value = false;
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

class QuizArguments {
  final String? sectionId;
  final Section? section;
  final String? subjectId;
  final Subject? subject;

  const QuizArguments(
      {this.sectionId, this.section, this.subjectId, this.subject});
}
