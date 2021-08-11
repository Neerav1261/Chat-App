// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   User? _userFromFirebaseUser(FirebaseUser user){
//     return user != null ? User(uid: user.uid, emailVerified: user.emailverified) : null;
//   }
//
//   Stream <User> get user {
//     return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
//   }
//
//   //sign out
//   Future signOut() async {
//     try{
//       return await _auth.signOut();
//     } catch(e) {
//       print(e);
//     }
//   }
// }
//
// //user class
// class User {
//   String uid;
//   bool emailVerified;
//   User({required this.uid, required this.emailVerified});
// }