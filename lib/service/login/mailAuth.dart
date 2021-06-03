import 'package:books_viewer/constant/errorMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAuth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<User> signUpWithEmailPassword(
      {@required email,
      @required password,
      @required BuildContext context}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        ErrorMessage.showSnackMessage(
          message: e.toString(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        ErrorMessage.showSnackMessage(
          message: e.toString(),
        ),
      );
    }
    return null;
  }

  Future<User> signInWithEmailPassword(
      {@required email,
      @required password,
      @required BuildContext context}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        ErrorMessage.showSnackMessage(
          message: e.toString(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        ErrorMessage.showSnackMessage(
          message: e.toString(),
        ),
      );
    }
    return null;
  }

  Future checkUserLogIn({@required BuildContext context}) async {
    User user = firebaseAuth.currentUser;
    if (user != null) {
      return user;
    }
  }
}
