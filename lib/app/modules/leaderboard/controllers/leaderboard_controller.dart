import 'package:get/get.dart';
import 'package:surgicalutopia/app/data/models/user_model.dart';
import 'package:surgicalutopia/app/data/providers/user_provider.dart';
import 'package:surgicalutopia/main.dart';

class LeaderboardController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<CustomUser> users = RxList.empty();

  @override
  void onInit() {
    getLeaderboard();
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

  Future<void> getLeaderboard() async {
    isLoading.value = true;
    final response = await getIt<UserProvider>().getLeaderboard();
    users.value = response ?? [];
    isLoading.value = false;
  }
}
