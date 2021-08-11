import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loading(String message, bool error) {
  return AlertDialog(
    elevation: 50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    title: error
        ? Icon(Icons.error, size: 50, color: Colors.red[500])
        : SpinKitCircle(
      color: Colors.blue[700],
      size: 50,
    ),
    content: SizedBox(
      height: error ? 55 : 45,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(message, textAlign: TextAlign.center),
      ),
    ),
  );
}
