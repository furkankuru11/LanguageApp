import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:languageapp/tools/selectedCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Column(
              children: [
                GestureDetector(
                  child: Container(
                    width: width * 0.6,
                    height: 50,
                    color: Colors.red,
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Container(
                    width: width * 0.6,
                    height: 50,
                    color: Colors.blue,
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Container(
                    width: width * 0.6,
                    height: 50,
                    color: Colors.green,
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: InkWell(
                    onTap: () {},
                    child: SelectedCard(
                      text: "Kelime Kartları",
                      icon: Icons.wordpress,
                      gColor1: Color.fromARGB(228, 243, 119, 30),
                      gColor2: Color.fromARGB(255, 238, 148, 30),
                    ),
                  ),
                ),
                Container(
                  child: InkWell(
                    onTap: () {},
                    child: SelectedCard(
                      text: "Çoktan Seçmeli",
                      icon: Icons.circle,
                      gColor1: Color.fromARGB(255, 13, 161, 38),
                      gColor2: Color.fromARGB(255, 17, 163, 49),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
