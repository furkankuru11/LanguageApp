import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateList extends StatefulWidget {
  const CreateList({super.key});

  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  final _listName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "İngilizce Sözlük",
          style: GoogleFonts.notoSansOsmanya(
              color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Center(
              child: textFieldBuilder(
                  width: width,
                  icon: Icon(Icons.list),
                  textEditingController: _listName,
                  hintText: "Listeyi Arat",
                  textAlign: TextAlign.left),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "İngilizce",
                    style: GoogleFonts.aboreto(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Türkçe",
                    style: GoogleFonts.aboreto(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Container textFieldBuilder(
      {double width = 100,
      double height = 50,
      @required TextEditingController? textEditingController,
      Icon? icon = null,
      String? hintText,
      TextAlign textAlign = TextAlign.center}) {
    return Container(
      height: height,
      width: width * 0.85,
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
}
