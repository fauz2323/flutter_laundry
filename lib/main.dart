import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(MyApps());
}

class MyApps extends StatelessWidget {
  const MyApps({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: Color(0xfff3f3fb),
        appBarTheme: AppBarTheme(
          color: Color(0xfff3f3fb),
        ),
      ),
      getPages: AppPages.routes,
    );
  }
}
