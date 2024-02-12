import 'package:flutter/material.dart';

PreferredSize appBar(context,
    {Widget? left,
    @required Widget? center,
    Widget? right,
    Function? leftWidgetOnClick}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50),
    child: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width * 0.2,
            child: InkWell(
              onTap: () => leftWidgetOnClick,
              child: left,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            alignment: Alignment.center,
            child: Center(child: center),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            alignment: Alignment.centerRight,
            child: Center(child: right),
          ),
        ],
      ),
    ),
  );
}
