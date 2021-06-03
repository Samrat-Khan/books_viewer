import 'package:books_viewer/constant/constName.dart';
import 'package:books_viewer/controller/authController.dart';
import 'package:books_viewer/service/db/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FbAuth {
  static String name, email, profileUrl, userId;

  static Future<User> signInWithFacebook(BuildContext context) async {
    final authController = AuthController.to;
    final LoginResult loginResult = await FacebookAuth.instance.login();
    AccessToken accessToken = loginResult.accessToken;

    final facebookAuthCredential =
        FacebookAuthProvider.credential(accessToken.token);

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);

    User user = FirebaseAuth.instance.currentUser;
    name = userCredential.additionalUserInfo.profile["name"];
    email = userCredential.additionalUserInfo.profile["email"];
    profileUrl =
        userCredential.additionalUserInfo.profile["picture"]["data"]["url"];
    userId = user.uid;

    if (userCredential.additionalUserInfo.isNewUser && user != null) {
      await UserData.addUser(
          name: name,
          email: email,
          profileUrl: profileUrl,
          userId: userId,
          context: context);
      authController.setUserName(name: name);
      authController.setUserEmail(email: email);
      authController.setUserProfileUrl(profileUrl: profileUrl);
      authController.setUserUID(userId: userId);
    }
    return user;
  }

  /// This Method used to Not use upper function this is sorter than signInWithFacebook()
  // static Future<User> logInWithFacebook() async {
  //   final LoginResult result = await FacebookAuth.instance
  //       .login(); // by default we request the email and the public profile
  //   if (result.status == LoginStatus.success) {
  //     // you are logged
  //     result.accessToken.token
  //     User user = FirebaseAuth.instance.currentUser;
  //     return user;
  //   } else
  //     return null;
  // }

  static Future<User> checkAlreadyloggedIn() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final authController = AuthController.to;
    User user = FirebaseAuth.instance.currentUser;
    await _firestore
        .collection(userCollectionName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        authController.setUserName(name: doc["name"]);
        authController.setUserEmail(email: doc["email"]);
        authController.setUserProfileUrl(profileUrl: doc["profileUrl"]);
        authController.setUserUID(userId: doc["userId"]);
      });
    });
    return user;
  }
}
