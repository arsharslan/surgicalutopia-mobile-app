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
import '../modules/quiz/bindings/quiz_binding.dart';
import '../modules/quiz/views/quiz_view.dart';
import '../modules/quiz_result/bindings/quiz_result_binding.dart';
import '../modules/quiz_result/views/quiz_result_view.dart';
import '../modules/section_detail/bindings/section_detail_binding.dart';
import '../modules/section_detail/views/section_detail_view.dart';
import '../modules/subject_detail/bindings/subject_detail_binding.dart';
import '../modules/subject_detail/views/subject_detail_view.dart';

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
    GetPage(
      name: _Paths.SUBJECT_DETAIL,
      page: () => const SubjectDetailView(),
      binding: SubjectDetailBinding(),
    ),
    GetPage(
      name: _Paths.SECTION_DETAIL,
      page: () => const SectionDetailView(),
      binding: SectionDetailBinding(),
    ),
    GetPage(
      name: _Paths.QUIZ,
      page: () => const QuizView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: _Paths.QUIZ_RESULT,
      page: () => const QuizResultView(),
      binding: QuizResultBinding(),
    ),
  ];
}
