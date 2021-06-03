import 'package:books_viewer/constant/constName.dart';
import 'package:books_viewer/constant/errorMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserData {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future addUser(
      {@required String name,
      @required String email,
      @required String profileUrl,
      @required String userId,
      @required BuildContext context}) async {
    try {
      await _firestore.collection(userCollectionName).doc(userId).set(
        {
          "name": name,
          "email": email,
          "profileUrl": profileUrl,
          "userId": userId,
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          ErrorMessage.showSnackMessage(message: "An Error Occured"));
    }
  }

  static Future getUser(
      {@required String userId, @required BuildContext context}) async {
    try {
      DocumentSnapshot getData =
          await _firestore.collection("Users").doc(userId).get();
      if (getData.exists) {
        return getData;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        ErrorMessage.showSnackMessage(message: "An Error Occured"),
      );
    }
  }
}
