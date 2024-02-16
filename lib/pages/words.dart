import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:languageapp/db/db/db.dart';
import 'package:languageapp/db/model/words.dart';

class WordsPage extends StatefulWidget {
  final int? listID;
  final String? listName;
  const WordsPage({super.key, this.listID, this.listName});

  @override
  State<WordsPage> createState() =>
      _WordsPageState(listID: listID, listName: listName);
}

class _WordsPageState extends State<WordsPage> {
  int? listID;
  String? listName;

  _WordsPageState({@required this.listID, @required this.listName});
  List<Word> _wordList = [];

  @override
  void initState() {
    // TODO: implement initState
    debugPrint(listID.toString() + "   " + listName!);
    getWordByList();
  }

  void getWordByList() async {
    _wordList = await DB.instance.readWordByList(listID);
    setState(() {
      _wordList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "$listName",
          style: GoogleFonts.notoSansOsmanya(
              color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
          child: ListView.builder(
        itemBuilder: (context, index) {
          return wordItem(_wordList[index].id!, index,
              word_eng: _wordList[index].word_eng,
              word_tr: _wordList[index].word_tr,
              status: _wordList[index].status!);
        },
        itemCount: _wordList.length,
      )),
    );
  }
}

wordItem(int wordID, int index,
    {@required String? word_tr,
    @required String? word_eng,
    @required bool? status}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Color.fromARGB(255, 58, 57, 57),
    ),
    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
    width: double.infinity,
    height: 60,
    child: Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 80, right: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  word_tr!,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "-",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  word_eng!,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
