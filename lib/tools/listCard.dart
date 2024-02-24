import 'package:flutter/material.dart';

class ListCard extends StatefulWidget {
  String listeAdi = "1.Liste";
  int terimSayisi = 0;
  int ogrenilenKelimeSayisi = 0;
  int ogrenilmeyenKelimeSayisi = 0;

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.red,
            ),
            margin: EdgeInsets.only(top: 20),
            width: width * 0.8,
            height: 130,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        widget.listeAdi,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "${widget.terimSayisi}: Terim",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "${widget.ogrenilenKelimeSayisi}: Kelime Öğrenildi",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "${widget.ogrenilmeyenKelimeSayisi}: Kelime Öğrenilecek",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
