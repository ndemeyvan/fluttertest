import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_test/constant.dart';
import 'package:flutter_app_test/signup_page.dart';

void main() async {
  // Call this first to make sure we can make other system level calls safely
  WidgetsFlutterBinding.ensureInitialized();

  // Status bar style on Android/iOS
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle());

  // Only portrait
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignupPage(),
    );
  }
}
