import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget buildSpinKit() {
  return SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color:
              index.isEven ? const Color(0xFFADD9D1) : const Color(0xFFADD9D1),
        ),
      );
    },
  );
}
