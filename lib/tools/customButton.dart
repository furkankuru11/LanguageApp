import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final Color backgroundColor;

  const customButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.icon,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          minimumSize: MaterialStateProperty.all(Size.zero), // Genişlik sıfır
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(15), // Köşe yuvarlaklığı sıfır
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
