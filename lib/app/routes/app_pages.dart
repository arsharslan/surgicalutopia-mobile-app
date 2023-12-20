import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../modules/email_login/bindings/email_login_binding.dart';
import '../modules/email_login/views/email_login_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/phone_number/bindings/phone_number_binding.dart';
import '../modules/phone_number/views/phone_number_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String get INITIAL => FirebaseAuth.instance.currentUser == null
      ? Routes.PHONE_NUMBER
      : Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.EMAIL_LOGIN,
      page: () => const EmailLoginView(),
      binding: EmailLoginBinding(),
    ),
    GetPage(
      name: _Paths.PHONE_NUMBER,
      page: () => const PhoneNumberView(),
      binding: PhoneNumberBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
  ];
}
