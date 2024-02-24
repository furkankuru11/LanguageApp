import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:languageapp/db/db/db.dart';
import 'package:languageapp/db/model/words.dart';
import 'package:languageapp/global_widget/toast.dart';

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
  bool pressController = false;
  List<bool> deleteIndexList = [];

  @override
  void initState() {
    // TODO: implement initState
    debugPrint(listID.toString() + "   " + listName!);
    getWordByList();
  }

  void getWordByList() async {
    _wordList = await DB.instance.readWordByList(listID);
    for (int i = 0; i < _wordList.length; i++) {
      deleteIndexList.add(false);
    }
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

  wordItem(
    int wordID,
    int index, {
    @required String? word_tr,
    @required String? word_eng,
    @required bool? status,
  }) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        _wordList[index] = _wordList[index].copy(status: true);
        if (status == true && direction == DismissDirection.startToEnd) {
          toastMessage("Öğrenildi Olarak İşaretlendi", Colors.green);
          DB.instance.markAsLearned(true, _wordList[index].id as int);

          print("Öğrenildi :" + word_tr);
        } else if (status == true && direction == DismissDirection.endToStart) {
          deleteIndexList[index] = true;
          _wordList.removeAt(index);
          toastMessage("Kelime Silindi", Colors.red);
        } else {
          toastMessage("Öğrenilemedi", Colors.red);
          DB.instance.markAsLearned(false, _wordList[index].id as int);
          print("Öğrenilemedi :" + word_tr);
        }
        setState(() {
          _wordList;
        });
      },
      background: Container(
        color: Color(0xC302A675),
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.0,
            ),
            child: Icon(
              Icons.done,
              color: Color.fromARGB(195, 246, 248, 247),
            ),
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Color.fromARGB(248, 247, 31, 31),
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.0,
            ),
            child: Icon(
              Icons.delete,
              color: Color.fromARGB(195, 246, 248, 247),
            ),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromARGB(255, 211, 77, 0),
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
      ),
    );
  }
}
