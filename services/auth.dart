import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import './../models/user.dart';
import 'database.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // User _userFromFirebaseUser(FirebaseUser user) {
  //   return user != null ? User(uid: user.uid)
  // }

  UserCls? _userCls(User? user) {
    return user != null ? UserCls(uid: user.uid) : null ;
    // UserCls(uid: user!.uid);
  }

  Stream<UserCls?> get user {
    return _auth.authStateChanges()
    // .map((User? user) => _userCls(user)) ;
        .map(_userCls);
  }

  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user ;
      return _userCls(user!) ;
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
      return null ;
    }
  }

  Future registerwithemailandpassword(String email , String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user ;

      await DBService(uid : user!.uid ).updateUserData('New User', '0' );

      return _userCls(user);
    }catch (e){
      if (kDebugMode) {
        print(e.toString());
      }
      return null ;
    }
  }


  Future signinwithemailandpassword(String email , String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user ;
      return _userCls(user);
    }catch (e){
      if (kDebugMode) {
        print(e.toString());
      }
      return null ;
    }
  }


  Future signOut() async {
    try{
      return await _auth.signOut() ;
    }catch(e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

}