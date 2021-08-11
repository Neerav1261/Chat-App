import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBaseService {
  final String uid;

  DataBaseService({required this.uid});

  final CollectionReference userData = FirebaseFirestore.instance.collection('UserData');
}