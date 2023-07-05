import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

void main() async {
  // below statement to first run all the widgets for once before firebase
  WidgetsFlutterBinding.ensureInitialized();
  // we wait for firebase to initialize before runApp runs
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // getmaterialapp bcz of using getx
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            // to set appbar icon colors
            iconTheme: IconThemeData(
              color: darkFontGrey,
            ),
            backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
