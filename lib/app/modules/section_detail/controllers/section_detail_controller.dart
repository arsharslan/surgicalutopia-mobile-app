import 'package:get/get.dart';
import 'package:surgicalutopia/app/data/models/section_model.dart';
import 'package:surgicalutopia/app/data/models/subject_model.dart';
import 'package:surgicalutopia/app/data/providers/section_provider.dart';
import 'package:surgicalutopia/app/data/providers/subject_provider.dart';
import 'package:surgicalutopia/main.dart';

class SectionDetailController extends GetxController {
  RxBool isLoading = false.obs;
  SectionDetailArguments? args;

  Subject? subject;
  Section? section;

  @override
  void onInit() {
    if (Get.arguments is SectionDetailArguments) {
      args = Get.arguments;
    }
    instantiate();
    super.onInit();
  }

  Future<void> instantiate() async {
    isLoading.value = true;
    subject = args?.subject ??
        await getIt<SubjectProvider>().getSubject(args?.subjectId ?? "");
    section = args?.section ??
        await getIt<SectionProvider>().getSection(args?.sectionId ?? "");
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

class SectionDetailArguments {
  final String? sectionId;
  final Section? section;
  final String? subjectId;
  final Subject? subject;

  const SectionDetailArguments(
      {this.sectionId, this.section, this.subjectId, this.subject});
}
