// import 'package:flutter/material.dart';

// class BookModel {
//   BookModel({
//     @required this.bookName,
//     @required this.bookPhotoUrl,
//     @required this.bookAuthorName,
//     @required this.aboutThisBook,
//     @required this.bookAddedBy,
//     @required this.bookId,
//     @required this.bookSortId,
//     @required this.totalLikes,
//     @required this.likes,
//   });

//   final String bookName;
//   final String bookPhotoUrl;
//   final String bookAuthorName;
//   final String aboutThisBook;
//   final String bookAddedBy;
//   final String bookId;
//   final String bookSortId;
//   final String totalLikes;
//   final Map likes;

//   // factory BookModel.fromRawJson(String str) =>
//   //     BookModel.fromJson(json.decode(str));

//   // String toRawJson() => json.encode(toJson());

//   factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
//         bookName: json["bookName"],
//         bookPhotoUrl: json["bookPhotoUrl"],
//         bookAuthorName: json["bookAuthorName"],
//         aboutThisBook: json["aboutThisBook"],
//         bookAddedBy: json["bookAddedBy"],
//         bookId: json["bookId"],
//         bookSortId: json["bookSortId"],
//         totalLikes: json["totalLikes"],
//         likes: json["likes"],
//       );

//   Map<String, dynamic> toJson() => {
//         "bookName": bookName,
//         "bookPhotoUrl": bookPhotoUrl,
//         "bookAuthorName": bookAuthorName,
//         "aboutThisBook": aboutThisBook,
//         "bookAddedBy": bookAddedBy,
//         "bookId": bookId,
//         "bookSortId": bookSortId,
//         "totalLikes": totalLikes,
//         "likes": likes,
//       };
// }
