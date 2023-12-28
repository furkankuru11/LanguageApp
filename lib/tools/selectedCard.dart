import 'package:flutter/material.dart';

class SelectedCard extends StatelessWidget {
  final String text;
  final IconData icon;

  final Color gColor1;
  final Color gColor2;

  SelectedCard(
      {super.key,
      required this.text,
      required this.icon,
      required this.gColor1,
      required this.gColor2});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Card(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              gColor1,
              gColor2,
            ],
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        width: width * 0.45,
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: width,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 40, bottom: 70),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              width: width,
              child: Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
