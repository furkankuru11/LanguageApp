import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:languageapp/pages/list.dart';
import 'package:languageapp/tools/drawer.dart';
import 'package:languageapp/tools/selectedCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int selectedValue = 0; // Default selected value for RadioListTile

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
      drawer: DrawerMenu(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Column(
              children: [
                Container(
                  width: width * 0.7,
                  child: RadioListTile(
                    title: Text(
                      'İngilizce-Türkçe',
                      style: TextStyle(color: Colors.black),
                    ),
                    value: 1,
                    groupValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as int;
                      });
                    },
                    activeColor: Colors.red,
                  ),
                ),
                Container(
                  width: width * 0.7,
                  child: RadioListTile(
                    title: Text(
                      'Türkçe-İngilizce',
                      style: TextStyle(color: Colors.black),
                    ),
                    value: 2,
                    groupValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as int;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: width * 0.8,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ListPage()));
                    },
                    child: Text(
                      "Listelerim",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
