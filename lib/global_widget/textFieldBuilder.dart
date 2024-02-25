import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";

Container textFieldBuilder({
  double width = 0,
  double height = 50,
  @required TextEditingController? textEditingController,
  Icon? icon = null,
  String? hintText,
  TextAlign textAlign = TextAlign.center,
}) {
  return Container(
    height: height,
    width: width,
    padding: EdgeInsets.only(left: 15, right: 15),
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.2),
    ),
    margin: EdgeInsets.only(top: 10),
    child: TextField(
      keyboardType: TextInputType.name,
      maxLines: 1,
      textAlign: textAlign,
      controller: textEditingController,
      style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 20),
      decoration: InputDecoration(
        icon: icon,
        border: InputBorder.none,
        hintText: hintText,
        fillColor: Colors.transparent,
      ),
    ),
  );
}
