import 'dart:io';

import 'package:books_viewer/constant/theme.dart';
import 'package:books_viewer/controller/authController.dart';
import 'package:books_viewer/service/db/book.dart';
import 'package:books_viewer/service/imagePick.dart';
import 'package:books_viewer/utils/textFiled.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBokkState createState() => _AddBokkState();
}

class _AddBokkState extends State<AddBook> {
  TextEditingController _bookName = TextEditingController();
  TextEditingController _bookAuthorName = TextEditingController();
  TextEditingController _bookDescription = TextEditingController();
  final authController = AuthController.to;
  File _fileImage;
  String _isSelected = "No Catagory";
  bool _isImageLoading = false;
  List chipName = [
    "Horror",
    "Mystry",
    "Romantic",
    "Adventure",
    "Classic",
    "Comic",
    "Fantasy",
    "No Catagory",
  ];

  ImagePick _imagePick = ImagePick();
  _callPickImage() async {
    setState(() async {
      _fileImage = await _imagePick.pickImageFromGallery();
    });
  }

  _clearField() {
    setState(() {
      _fileImage = null;
      _isSelected = "No Catagory";
    });
    _bookAuthorName.clear();
    _bookDescription.clear();
    _bookName.clear();
  }

  _uploadBookData() async {
    await Book.addBook(
            fileImage: _fileImage,
            bookName: _bookName.text,
            bookAuthorName: _bookAuthorName.text,
            aboutThisBook: _bookDescription.text,
            bookAddedBy: authController.userUid.value,
            bookType: _isSelected,
            context: context)
        .whenComplete(() {
      _clearField();
      Get.back();
    });
  }

  @override
  void dispose() {
    _bookAuthorName.dispose();
    _bookName.dispose();
    _bookDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: _callPickImage,
                child: Container(
                  width: size.width * 0.3,
                  height: size.height / 7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: _fileImage == null
                          ? AssetImage("assets/images/no-img.png")
                          : FileImage(_fileImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              customTextField(
                size: size,
                hintText: "Byomkesh",
                controller: _bookName,
                widthVal: 0.5,
                needMultiline: false,
              ),
            ],
          ),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 10.0,
            runSpacing: 3.0,
            children: _buildChoiceList(),
          ),
          customTextField(
            size: size,
            hintText: "Author Name",
            controller: _bookAuthorName,
            widthVal: 0.8,
            needMultiline: false,
          ),
          customTextField(
            size: size,
            hintText: "Book Description",
            controller: _bookDescription,
            widthVal: 0.8,
            needMultiline: true,
          ),
          // Obx(
          //   () => Text(authController.userUID.value),
          // ),
          // Container(
          //   width: 90,
          //   height: 70,
          //   child: TextField(
          //     onChanged: (val) {
          //       authController.setUserUID(userID: val);
          //     },
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _clearField,
                child: Text("Clear"),
              ),
              ElevatedButton(
                onPressed: _uploadBookData,
                child: Text("Upload"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    chipName.forEach((item) {
      choices.add(Container(
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(color: Colors.white),
          selectedColor: Colors.pinkAccent,
          backgroundColor: Colors.deepPurpleAccent,
          selected: _isSelected == item,
          onSelected: (selected) {
            setState(() {
              _isSelected = item;
            });
          },
        ),
      ));
    });
    return choices;
  }
}
