import 'package:books_viewer/constant/theme.dart';
import 'package:books_viewer/controller/authController.dart';
import 'package:books_viewer/screens/addBook.dart';
import 'package:books_viewer/screens/home.dart';
import 'package:books_viewer/screens/logIn.dart';
import 'package:books_viewer/screens/tab/detail.dart';
import 'package:books_viewer/utils/dismissbleKeyboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return DismissKeyboard(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Customtheme.darkTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => LogIn(),
          '/Home': (context) => Home(),
          '/BookDetail': (context) => BookDetail(),
          '/AddBook': (context) => AddBook(),
        },
      ),
    );
  }
}
