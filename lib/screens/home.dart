import 'package:books_viewer/controller/authController.dart';
import 'package:books_viewer/screens/tab/pageTab.dart';
import 'package:books_viewer/utils/booksCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final authController = AuthController.to;

  List<String> tabName = [
    "All",
    "Horror",
    "Mystry",
    "Romantic",
    "Adventure",
    "Classic",
    "Comic",
    "Fantasy",
    "No Catagory",
  ];
  List<IconData> tabIcon = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: tabName.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 100.0,
                elevation: 0,
                pinned: true,
                floating: true,
                title: Text("vBook"),
                leading: IconButton(icon: Icon(Icons.logout), onPressed: () {}),
                actions: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        NetworkImage(authController.userProfileUrl.value),
                  ),
                  SizedBox(width: 10),
                ],
                bottom: TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(
                      text: tabName[0],
                    ),
                    Tab(
                      text: tabName[1],
                    ),
                    Tab(
                      text: tabName[2],
                    ),
                    Tab(
                      text: tabName[3],
                    ),
                    Tab(
                      text: tabName[4],
                    ),
                    Tab(
                      text: tabName[5],
                    ),
                    Tab(
                      text: tabName[6],
                    ),
                    Tab(
                      text: tabName[7],
                    ),
                    Tab(
                      text: tabName[8],
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              TabPage(bookType: tabName[0]),
              TabPage(bookType: tabName[1]),
              TabPage(bookType: tabName[2]),
              TabPage(bookType: tabName[3]),
              TabPage(bookType: tabName[4]),
              TabPage(bookType: tabName[5]),
              TabPage(bookType: tabName[6]),
              TabPage(bookType: tabName[7]),
              TabPage(bookType: tabName[8]),
            ],
          ),
        ),
      ),
    );
  }
}
