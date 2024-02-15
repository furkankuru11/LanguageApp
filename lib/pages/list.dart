import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:languageapp/pages/create_list.dart';
import 'package:languageapp/tools/listCard.dart';
import 'package:languageapp/db/db/db.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Map<String, Object?>> _lists = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  void getList() async {
    _lists = await DB.instance.readListAll();
    setState(() {
      _lists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateList()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
        backgroundColor: Colors.green,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "İngilizce Sözlük",
          style: GoogleFonts.notoSansOsmanya(
              color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              ListCard(),
              ListCard(),
            ]),
            color: Colors.white,
          ),
        )),
      ),
    );
  }
}
