import 'package:get/get.dart';
import 'package:surgicalutopia/app/data/models/user_model.dart';
import 'package:surgicalutopia/app/data/providers/user_provider.dart';
import 'package:surgicalutopia/main.dart';
import 'package:surgicalutopia/utils/shared_preferences.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  Rxn<CustomUser> user = Rxn();

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getUser() async {
    if (PreferencesHelper.instance.mongoUserID == null) {
      return;
    }
    isLoading.value = true;
    final user = await getIt<UserProvider>().getUser();
    this.user.value = user;
    isLoading.value = false;
  }
}
