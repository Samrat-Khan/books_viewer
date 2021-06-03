import 'package:flutter/material.dart';

Container customTextField({
  @required Size size,
  double widthVal,
  bool needMultiline,
  @required String hintText,
  @required TextEditingController controller,
}) {
  return Container(
    width: size.width * widthVal,
    height: needMultiline ? 180 : null,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      controller: controller,
      keyboardType:
          needMultiline ? TextInputType.multiline : TextInputType.name,
      maxLines: null,
      minLines: null,
      expands: needMultiline,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.deepPurpleAccent,
        contentPadding: EdgeInsets.only(left: 10),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white70,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
