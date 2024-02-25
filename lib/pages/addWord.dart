import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:languageapp/db/db/db.dart';
import 'package:languageapp/db/model/list.dart';
import 'package:languageapp/db/model/words.dart';
import 'package:languageapp/global_widget/textFieldBuilder.dart';
import 'package:languageapp/global_widget/toast.dart';
import 'package:languageapp/pages/create_list.dart';

class AddWordPage extends StatefulWidget {
  final int? listID;
  final String? listName;
  const AddWordPage(this.listID, this.listName, {Key? key}) : super(key: key);

  @override
  State<AddWordPage> createState() =>
      _AddWordPageState(listID: listID, listName: listName);
}

class _AddWordPageState extends State<AddWordPage> {
  int? listID;
  String? listName;
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < 6; ++i)
      wordTextEditingList.add(TextEditingController());

    for (int i = 0; i < 3; ++i) {
      debugPrint((2 * i).toString() + "--------" + (2 * i + 1).toString());

      wordListField.add(Row(
        children: [
          Expanded(
            child: textFieldBuilder(
              textEditingController: wordTextEditingList[2 * i],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: textFieldBuilder(
              textEditingController: wordTextEditingList[(2 * i) + 1],
            ),
          ),
        ],
      ));
    }
  }

  _AddWordPageState({@required this.listID, @required this.listName});
  final _listName = TextEditingController();
  List<Row> wordListField = [];
  List<TextEditingController> wordTextEditingList = [];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "İngilizce",
                      style: GoogleFonts.aboreto(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Türkçe",
                      style: GoogleFonts.aboreto(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: wordListField,
                    ),
                  ),
                ),
              ),
              ButtonRow(
                addRow: addRow,
                deleteRow: deleteRow,
                save: saveRow,
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "$listName",
          style: GoogleFonts.notoSansOsmanya(
              color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void addRow() {
    wordTextEditingList.add(TextEditingController());
    wordTextEditingList.add(TextEditingController());
    wordListField.add(Row(
      children: [
        Expanded(
            child: textFieldBuilder(
                textEditingController:
                    wordTextEditingList[wordTextEditingList.length - 2])),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: textFieldBuilder(
                textEditingController:
                    wordTextEditingList[wordTextEditingList.length - 1])),
      ],
    ));
    setState(() {
      wordListField;
    });
  }

  void deleteRow() {
    if (wordListField.length != 4) {
      wordTextEditingList.removeAt(wordTextEditingList.length - 1);
      wordTextEditingList.removeAt(wordTextEditingList.length - 1);
      wordListField.removeAt(wordListField.length - 1);
      setState(() {
        wordListField;
      });
    } else {
      toastMessage("Minimum 1 Eleman Olmalıdır", Colors.orange);
      debugPrint("1 Eleman olmak zorunda");
    }
  }

  void saveRow() async {
    int counter = 0;
    bool notEmptyPair = false;

    for (int i = 0; i < wordTextEditingList.length / 2; i++) {
      String eng = wordTextEditingList[2 * i].text;
      String tr = wordTextEditingList[2 * i + 1].text;

      if (eng.isNotEmpty && tr.isNotEmpty) {
        counter++;
      } else {
        notEmptyPair = true;
      }
    }
    if (counter >= 1) {
      if (notEmptyPair == false) {
        Lists addedList =
            await DB.instance.insertList(Lists(name: _listName.text));
        for (int i = 0; i < wordTextEditingList.length / 2; i++) {
          String eng = wordTextEditingList[2 * i].text;
          String tr = wordTextEditingList[2 * i + 1].text;

          Word word = await DB.instance.insertWord(
              Word(list_id: listID, word_eng: eng, word_tr: tr, status: false));

          print(word.id.toString() +
              "  " +
              word.list_id.toString() +
              "    " +
              word.word_eng.toString() +
              "   " +
              word.word_tr.toString() +
              " " +
              word.status.toString());
        }

        toastMessage("Kelimeler Eklendi", Colors.green);

        wordTextEditingList.forEach((element) {
          element.clear();
        });
        print("Kelime Oluşturuldu");
      } else {
        toastMessage("Boş Alanları Doldurun veya Silin", Colors.orange);
        print("Boş alanları silin");
      }
    } else {
      toastMessage("Minimum 1 Çift Olmalıdır", Colors.orange);
      print("minimum 1 tane olmak zorunda");
    }

    for (int i = 0; i < wordTextEditingList.length / 2; i++) {
      String eng = wordTextEditingList[2 * i].text;
      String tr = wordTextEditingList[2 * i + 1].text;
      if (!eng.isEmpty || !tr.isEmpty)
        debugPrint(eng + "-------------" + tr);
      else {}
    }
  }
}
