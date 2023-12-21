import 'package:get/get.dart';
import 'package:surgicalutopia/app/data/models/subject_model.dart';
import 'package:surgicalutopia/app/data/providers/subject_provider.dart';
import 'package:surgicalutopia/main.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Subject> subjects = RxList.empty();

  @override
  void onInit() {
    super.onInit();
    getSubjects();
  }

  getSubjects() async {
    print("getting subjects");
    isLoading.value = true;
    subjects.value = (await getIt<SubjectProvider>().getSubjects()) ?? [];
    print(subjects);
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
