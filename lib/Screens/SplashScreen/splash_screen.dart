import 'dart:async';
import 'package:flutter/material.dart';
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'Splash_Screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushNamed(context, IntroScreen.id));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage('assets/chat_icon.png'),
                    height: 150,
                  ),
                ),
              ),
              Text('ChatApp',
                  style: TextStyle(
                      color: Colors.lightBlue[200],
                      fontFamily: 'OpenSans B',
                      fontSize: MediaQuery.of(context).size.width / 7,
                      //fontWeight: FontWeight.bold
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
