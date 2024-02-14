import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:languageapp/db/db/db.dart';
import 'package:languageapp/db/model/list.dart';
import 'package:languageapp/db/model/words.dart';
import 'package:languageapp/global_widget/toast.dart';
import 'package:languageapp/tools/customButton.dart';

class CreateList extends StatefulWidget {
  const CreateList({Key? key}) : super(key: key);

  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  final _listName = TextEditingController();
  List<Row> wordListField = [];
  List<TextEditingController> wordTextEditingList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < 10; ++i)
      wordTextEditingList.add(TextEditingController());

    for (int i = 0; i < 5; ++i) {
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "İngilizce Sözlük",
          style: GoogleFonts.notoSansOsmanya(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Center(
                child: textFieldBuilder(
                  width: width * 0.86,
                  icon: Icon(Icons.list),
                  textEditingController: _listName,
                  hintText: "Listeyi Arat",
                  textAlign: TextAlign.left,
                ),
              ),
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
      toastMessage("Minimum 4 Eleman Olmalıdır", Colors.orange);
      debugPrint("4 Eleman olmak zorunda");
    }
  }

  void saveRow() async {
    if (_listName.text.isNotEmpty) {
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
      if (counter >= 4) {
        if (notEmptyPair == false) {
          Lists addedList =
              await DB.instance.insertList(Lists(name: _listName.text));
          for (int i = 0; i < wordTextEditingList.length / 2; i++) {
            String eng = wordTextEditingList[2 * i].text;
            String tr = wordTextEditingList[2 * i + 1].text;

            Word word = await DB.instance.insertWord(Word(
                list_id: addedList.id,
                word_eng: eng,
                word_tr: tr,
                status: false));

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

          toastMessage("Liste Başarıyla Oluşturuldu", Colors.green);
          print("Liste Oluşturuldu");
        } else {
          toastMessage("Boş Alanları Doldurun veya Silin", Colors.orange);
          print("Boş alanları silin");
        }
      } else {
        toastMessage("Minimum 4  Çift Olmalıdır", Colors.orange);
        print("minimum 4 tane olmak zorunda");
      }

      for (int i = 0; i < wordTextEditingList.length / 2; i++) {
        String eng = wordTextEditingList[2 * i].text;
        String tr = wordTextEditingList[2 * i + 1].text;
        if (!eng.isEmpty || !tr.isEmpty)
          debugPrint(eng + "-------------" + tr);
        else {}
      }
    } else {
      toastMessage("Lütfen Liste Adı Giriniz!", Colors.orange);
      print("liste adı gir");
    }
  }

  Container textFieldBuilder({
    double width = 0,
    double height = 50,
    @required TextEditingController? textEditingController,
    Icon? icon = null,
    String? hintText,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
      ),
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        keyboardType: TextInputType.name,
        maxLines: 1,
        textAlign: textAlign,
        controller: textEditingController,
        style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 20),
        decoration: InputDecoration(
          icon: icon,
          border: InputBorder.none,
          hintText: hintText,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}

class ButtonRow extends StatelessWidget {
  final VoidCallback addRow;
  final VoidCallback deleteRow;
  final VoidCallback save;

  const ButtonRow(
      {Key? key,
      required this.addRow,
      required this.deleteRow,
      required this.save})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customButton(
            onPressed: () {
              deleteRow();
            },
            text: "Sil",
            icon: Icons.search,
            backgroundColor: Colors.red,
          ),
          customButton(
            onPressed: addRow,
            text: "Ekle",
            icon: Icons.add,
            backgroundColor: Colors.green,
          ),
          customButton(
            onPressed: () {
              save();
            },
            text: "Kaydet",
            icon: Icons.save,
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
