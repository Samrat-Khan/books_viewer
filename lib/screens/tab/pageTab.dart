import 'package:auto_animated/auto_animated.dart';
import 'package:books_viewer/constant/constName.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabPage extends StatefulWidget {
  final String bookType;

  const TabPage({Key key, this.bookType}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String bookName, bookPhotoUrl, bookAuthorName;
  String stremBookType;

  @override
  void initState() {
    setState(() {
      stremBookType = widget.bookType;
    });

    print("Init State BookType $stremBookType");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    print("Inside widget build ${widget.bookType}");
    return PageView(
      scrollDirection: Axis.vertical,
      children: [
        StreamBuilder(
            stream: widget.bookType == "All"
                ? _firestore
                    .collection(bookCollectionName)
                    .orderBy("timeStamp", descending: true)
                    .snapshots()
                : _firestore
                    .collection(bookCollectionName)
                    .where("bookType", isEqualTo: stremBookType)
                    .orderBy("timeStamp", descending: true)
                    .snapshots(),
            builder: (context, snapshot) {
              QuerySnapshot querySnapshot = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading"),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: Text("No Data"),
                );
              }

              return LiveGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: querySnapshot.docs.length,
                itemBuilder: (ctx, i, animation) {
                  var data = querySnapshot.docs[i];
                  bookName = data["bookName"];
                  bookPhotoUrl = data["bookPhotoUrl"];
                  bookAuthorName = data["bookAuthorName"];

                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        '/BookDetail',
                        arguments: {
                          "bookName": data["bookName"],
                          "bookPhotoUrl": data["bookPhotoUrl"],
                          "bookAuthorName": data["bookAuthorName"],
                          "aboutThisBook": data["aboutThisBook"],
                          "bookAddedBy": data["bookAddedBy"],
                          "bookId": data["bookId"],
                          "timeStamp": data["timeStamp"],
                          "likes": data["likes"],
                          "totalLikes": data["totalLikes"],
                          "bookType": data["bookType"],
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: bookPhotoUrl == null
                                    ? AssetImage("assets/images/2.jpg")
                                    : NetworkImage(bookPhotoUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text("$bookName"),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ],
    );
  }
}


//              return GridView.builder(
                  // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  //     maxCrossAxisExtent: 200,
                  //     childAspectRatio: 3 / 2,
                  //     crossAxisSpacing: 20,
                  //     mainAxisSpacing: 20,
                  // ),
                  // itemCount: 20,
                  // itemBuilder: (BuildContext ctx, index) {
                  //   return Container(
                  //     alignment: Alignment.center,
                  //     child: Text("myProducts[index][name"),
                  //     decoration: BoxDecoration(
                  //         color: Colors.amber,
                  //         borderRadius: BorderRadius.circular(15)),
                  //   );
                  // });