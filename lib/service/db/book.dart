import 'dart:io';

import 'package:books_viewer/service/db/user.dart';
import 'package:books_viewer/constant/constName.dart';
import 'package:books_viewer/constant/errorMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Book {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Uuid uuid = Uuid();
  static DateTime _dateTime = DateTime.now();
  static Future addBook(
      {@required File fileImage,
      @required String bookName,
      @required String bookAuthorName,
      @required String aboutThisBook,
      @required String bookAddedBy,
      @required String bookType,
      @required BuildContext context}) async {
    String bookId = uuid.v4();

    try {
      await _firestore.collection(bookCollectionName).doc(bookId).set({
        "bookName": bookName,
        "bookPhotoUrl": await uploadPhotoToFirebase(
            fileImage: fileImage, bookId: bookId, context: context),
        "bookAuthorName": bookAuthorName,
        "aboutThisBook": aboutThisBook,
        "bookAddedBy": bookAddedBy,
        "bookId": bookId,
        "timeStamp": _dateTime.microsecondsSinceEpoch,
        "likes": {},
        "totalLikes": 0,
        "bookType": bookType,
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(ErrorMessage.showSnackMessage(message: e.toString()));
    }
  }

  static Future updateLike(
      {@required bool isLiked,
      @required String userId,
      @required int totalUpdatedLike,
      @required String bookId,
      @required BuildContext context}) async {
    try {
      await _firestore.collection(bookCollectionName).doc(bookId).update({
        "likes": {"$userId": isLiked},
        "totalLikes": totalUpdatedLike,
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          ErrorMessage.showSnackMessage(message: "An Error Occured"));
    }
  }

  static Future addComment(
      {@required String bookId,
      @required String message,
      @required String userId,
      @required BuildContext context}) async {
    String commentId = uuid.v1();

    try {
      await _firestore.collection(commentsCollectionName).doc(bookId).set({
        "commentId": commentId,
        "message": message,
        "userId": userId,
        "bookId": bookId,
        "timeStamp": _dateTime.microsecondsSinceEpoch,
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          ErrorMessage.showSnackMessage(message: "An Error Occured"));
    }
  }

  static Future addBookmark({
    @required BuildContext context,
    @required String bookId,
    @required String userId,
  }) async {
    try {
      await _firestore
          .collection(userCollectionName)
          .doc(bookCollectionName)
          .collection(bookCollectionName)
          .doc()
          .set({
        "bookId": bookId,
        "userId": userId,
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          ErrorMessage.showSnackMessage(message: "An Error Occured"));
    }
  }

  static Future uploadPhotoToFirebase(
      {@required File fileImage,
      @required String bookId,
      @required BuildContext context}) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('BookImage/book_$bookId.png')
          .putFile(fileImage);
      String uploadPhotoLink = await firebase_storage.FirebaseStorage.instance
          .ref('BookImage/book_$bookId.png')
          .getDownloadURL();
      return uploadPhotoLink;
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(ErrorMessage.showSnackMessage(message: e.toString()));
    }
  }
}
