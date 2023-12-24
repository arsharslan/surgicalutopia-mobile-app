import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surgicalutopia/app/data/providers/section_provider.dart';
import 'package:surgicalutopia/app/data/providers/subject_provider.dart';
import 'package:surgicalutopia/widgets/unfocus_gesture/unfocus_gesture.dart';

import 'app/routes/app_pages.dart';

String baseURL = "http://16.171.230.157:5001/api/";
String firebaseURL =
    "https://firebasestorage.googleapis.com/v0/b/surgicalutopia-51861.appspot.com";
GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) {
        return UnFocusGesture(
          child: GetMaterialApp(
            title: "Application",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            theme: ThemeData(
                    scaffoldBackgroundColor:
                        const Color.fromRGBO(251, 246, 255, 1),
                    textTheme: GoogleFonts.poppinsTextTheme(
                        Theme.of(context).textTheme))
                .copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: Color(0xFF61D7B5),
                        secondary: Color(0xFFEF4F9C),
                        tertiary: const Color(0xFFFE9738),
                        background: const Color.fromRGBO(251, 246, 255, 1))),
          ),
        );
      }));

  getIt
    ..registerSingleton(SubjectProvider())
    ..registerSingleton(SectionProvider());
}
