import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/pages/main_page.dart';
import 'package:google_fonts/google_fonts.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold
          )
      ),

    ),

    initialRoute: '/',
    routes: {
      '/': (context) => MainPage()
    },
  ));
}
