import 'package:flutter/material.dart';
import 'package:languageapp/tools/spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class TemproryPage extends StatefulWidget {
  const TemproryPage({super.key});

  @override
  State<TemproryPage> createState() => _TemproryPageState();
}

class _TemproryPageState extends State<TemproryPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF027373),
            Color(0xFF038C7F),
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            width: width * 1,
            height: 300,
            child: Image.asset("assets/images/split_image.png"),
          ),
          SizedBox(
            height: 170,
          ),
          Container(
            color: Colors.red,
            width: width,
            child: Text(
              'İNGİLİZCE SÖZLÜK',
              style: GoogleFonts.kanit(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.blue,
                  child: buildSpinKit(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
