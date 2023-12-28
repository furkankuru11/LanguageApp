import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "İngilizce Sözlük",
          style: GoogleFonts.notoSansOsmanya(
              color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons.drag_handle),
          color: Colors.black,
          onPressed: () {},
        ),
      ),
      body: SafeArea(
          child: Container(
        color: Colors.red,
      )),
    );
  }
}
