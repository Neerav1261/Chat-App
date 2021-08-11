import 'package:chat_app/Screens/ChatScreen/chat_screen.dart';
import 'package:chat_app/Screens/HomePage/home_page.dart';
import 'package:chat_app/utility/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureTextLog = true;
  bool _valueCheckBox = false;
  Color? colorShow = Colors.grey[600];
  String email = '';
  String password = '';
  bool _validateEmail = false;
  bool _validatePass = false;
  bool showAlert = false;
  String message = '';
  bool error = false;
  bool loginProgress = false;
  bool _interaction = false;

  final _formKey = GlobalKey<FormState>();

  void _toggleLogIn() {
    setState(() {
      _obscureTextLog = !_obscureTextLog;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showAlert ? loading(message, error) : Padding(
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
      child: IgnorePointer(
        ignoring: _interaction,
        child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 6),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.mail, color: Colors.grey[600]),
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  fillColor: Colors.grey.withOpacity(0.2),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.grey[600]!,
                                        width: 1.5,
                                        style: BorderStyle.solid,
                                      )
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.red[500]!,
                                        width: 1.5,
                                        style: BorderStyle.solid,
                                      )
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.red[500]!,
                                        width: 1.5,
                                        style: BorderStyle.solid,
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  )
                                ),
                                onChanged: (value) {
                                  email = value;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 0),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey[600]),
                                    fillColor: Colors.grey.withOpacity(0.2),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.grey[600]!,
                                          width: 1.5,
                                          style: BorderStyle.solid,
                                        )
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.red[500]!,
                                          width: 1.5,
                                          style: BorderStyle.solid,
                                        )
                                    ),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.red[500]!,
                                          width: 1.5,
                                          style: BorderStyle.solid,
                                        )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    )
                                ),
                                obscureText: _obscureTextLog,
                                onChanged: (value) {
                                  password = value;
                                },
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 6),
                            child: Row(
                              children: [
                                Checkbox(
                                    value: _valueCheckBox,
                                    onChanged: (_valueCheckBox) {
                                      setState(() {
                                        this._valueCheckBox = _valueCheckBox!;
                                        _toggleLogIn();
                                      });
                                    }
                                ),
                                const Text('Show Password'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 6),
                            child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    setState(() {
                                      loginProgress = true;
                                      _interaction = true;
                                    });
                                    final newUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                                    if(newUser != null) {
                                      loginProgress = false;
                                      _interaction = false;
                                      Navigator.pushNamed(context, ChatScreen.id);
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                  print(email);
                                  print(password);
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                                    ),
                                  padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(35, 15, 35, 15)),
                                  backgroundColor: MaterialStateProperty.all(Colors.lightBlue[300]!),
                                ),
                                child: loginProgress ?
                                const Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child:  SizedBox(
                                    height: 17.5,
                                    width: 17.5,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ) : const Text('  Sign In  ')
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureTextLog = true;
  bool _valueCheckBox = false;
  Color? colorShow = Colors.grey[600];
  String name = '';
  String email = '';
  String password = '';
  bool _validateEmail = false;
  bool _validatePass = false;
  bool showAlert = false;
  String message = '';
  bool error = false;
  bool registerProgress = false;
  bool _interaction = false;

  final _formKey = GlobalKey<FormState>();

  void _toggleLogIn() {
    setState(() {
      _obscureTextLog = !_obscureTextLog;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return showAlert ? loading(message, error) : Padding(
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
      child: IgnorePointer(
        ignoring: _interaction,
        child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 6),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.account_circle, color: Colors.grey[600]),
                                    hintText: "Name",
                                    hintStyle: TextStyle(color: Colors.grey[600]),
                                    fillColor: Colors.grey.withOpacity(0.2),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.grey[600]!,
                                          width: 1.5,
                                          style: BorderStyle.solid,
                                        )
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.red[500]!,
                                          width: 1.5,
                                          style: BorderStyle.solid,
                                        )
                                    ),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.red[500]!,
                                          width: 1.5,
                                          style: BorderStyle.solid,
                                        )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    )
                                ),
                                onChanged: (value) {
                                  name = value;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 6),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.mail, color: Colors.grey[600]),
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey[600]),
                                    fillColor: Colors.grey.withOpacity(0.2),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.grey[600]!,
                                          width: 1.5,
                                          style: BorderStyle.solid,
                                        )
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.red[500]!,
                                          width: 1.5,
                                          style: BorderStyle.solid,
                                        )
                                    ),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.red[500]!,
                                          width: 1.5,
                                          style: BorderStyle.solid,
                                        )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    )
                                ),
                                onChanged: (value) {
                                  email = value;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 0),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey[600]),
                                    fillColor: Colors.grey.withOpacity(0.2),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.grey[600]!,
                                          width: 1.5,
                                          style: BorderStyle.solid,
                                        )
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.red[500]!,
                                          width: 1.5,
                                          style: BorderStyle.solid,
                                        )
                                    ),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.red[500]!,
                                          width: 1.5,
                                          style: BorderStyle.solid,
                                        )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    )
                                ),
                                obscureText: _obscureTextLog,
                                onChanged: (value) {
                                  password = value;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 6),
                            child: Row(
                              children: [
                                Checkbox(
                                    value: _valueCheckBox,
                                    onChanged: (_valueCheckBox) {
                                      setState(() {
                                        this._valueCheckBox = _valueCheckBox!;
                                        _toggleLogIn();
                                      });
                                    }
                                ),
                                const Text('Show Password'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 6),
                            child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    setState(() {
                                      registerProgress = true;
                                      _interaction = true;
                                    });
                                    final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                                    if(newUser != null) {
                                      registerProgress = false;
                                      _interaction = false;
                                      Navigator.pushNamed(context, ChatScreen.id);
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                  print(name);
                                  print(email);
                                  print(password);
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                                  ),
                                  padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(30, 15, 30, 15)),
                                  backgroundColor: MaterialStateProperty.all(Colors.lightBlue[300]!),
                                ),
                                child: registerProgress ?
                                const Padding(
                                  padding: EdgeInsets.only(left: 25, right: 25),
                                  child:  SizedBox(
                                    height: 17.5,
                                    width: 17.5,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ) : const Text('  Register  ')
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}

