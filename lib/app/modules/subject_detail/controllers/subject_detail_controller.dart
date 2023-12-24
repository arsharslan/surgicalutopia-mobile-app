import 'package:get/get.dart';
import 'package:surgicalutopia/app/data/models/section_model.dart';
import 'package:surgicalutopia/app/data/models/subject_model.dart';
import 'package:surgicalutopia/app/data/providers/section_provider.dart';
import 'package:surgicalutopia/app/data/providers/subject_provider.dart';
import 'package:surgicalutopia/main.dart';

class SubjectDetailController extends GetxController {
  SubjectDetailArguments? args;
  List<Section>? sections;
  Rxn<Subject> subject = Rxn();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    if (Get.arguments is SubjectDetailArguments) {
      args = Get.arguments;
    }
    getSections();
    super.onInit();
  }

  Future<void> getSections() async {
    if (args?.subjectId == null) {
      return;
    }
    isLoading.value = true;
    subject.value = args?.subject ??
        await getIt<SubjectProvider>().getSubject(args!.subjectId!);
    sections = await getIt<SectionProvider>().getSections(args!.subjectId!);
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

class SubjectDetailArguments {
  final String? subjectId;
  final Subject? subject;
  const SubjectDetailArguments({this.subjectId, this.subject});
}
