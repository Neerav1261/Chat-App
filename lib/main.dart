import 'package:chat_app/Screens/ChatScreen/chat_screen.dart';
import 'package:chat_app/Screens/HomePage/home_page.dart';
import 'package:chat_app/Screens/LoginScreen/login_reg_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/SplashScreen/intro_screen.dart';
import 'Screens/SplashScreen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id : (context) => const SplashScreen(),
        IntroScreen.id : (context) => const IntroScreen(),
        LogIn.id : (context) => const LogIn(),
        HomePage.id : (context) => const HomePage(),
        ChatScreen.id : (context) => const ChatScreen(),
      },
    );
  }
}

