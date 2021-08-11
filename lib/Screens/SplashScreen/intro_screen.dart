import 'package:chat_app/Screens/LoginScreen/login_reg_screen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  static String id = 'Intro_Screen';
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Welcome to ChatApp',
                  style: TextStyle(
                    color: Colors.lightBlue[200],
                    fontFamily: 'OpenSans R',
                    fontSize: MediaQuery.of(context).size.width / 12,
                    fontWeight: FontWeight.bold
                  )
              ),
              const Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage('assets/chat_icon.png'),
                    height: 130,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, LogIn.id);
                },
                child: CircleAvatar(
                  child: const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white),
                  backgroundColor: Colors.lightBlue[300]!.withOpacity(0.8),
                  radius: MediaQuery.of(context).size.width / 13,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
