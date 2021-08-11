import 'dart:ui';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'login_reg_widgets.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  static String id = 'Login_Screen';

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool check = false;
  Color? loginText = Colors.lightBlue[300]!.withOpacity(0.9);
  Color? loginColor = Colors.white;
  Color? registerColor = Colors.transparent;
  Color? registerText = Colors.white;

  @override
  Widget setState(fn) {
    super.setState(fn);
    return !check ? const Login() : const Register();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Hero(
                tag: 'logo',
                child: Image(
                  image: AssetImage('assets/chat_icon.png'),
                  height: 130,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 10),
                      child: Container(
                          width: 278,
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[300]!.withOpacity(0.9),
                            borderRadius: const BorderRadius.all(Radius.circular(40)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: loginColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        registerColor = Colors.transparent;
                                        loginColor = Colors.white;
                                        loginText = Colors.lightBlue[300]!.withOpacity(0.9);
                                        registerText = Colors.white;
                                        check = false;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                                      child: Text(
                                        '   Login   ',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: loginText,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: registerColor,
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                  ),
                                  child: GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            loginColor = Colors.transparent;
                                            registerColor = Colors.white;
                                            loginText = Colors.white;
                                            registerText = Colors.lightBlue[300]!.withOpacity(0.9);
                                            check = true;
                                          });
                                        },
                                        child: Text(
                                          'Register',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: registerText,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                    setState(() {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

