import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          )),
          Expanded(
              child: textFieldBuilder(
            textEditingController: wordTextEditingList[(2 * i) + 1],
          )),
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
              ButtonRow(),
            ],
          ),
        ),
      ),
    );
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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              // Silme butonu işlevi
              // Buraya silme işlemleri ekleyebilirsiniz.
            },
            child: Text("Sil"),
          ),
          ElevatedButton(
            onPressed: () {
              // Ekleme butonu işlevi
              // Buraya ekleme işlemleri ekleyebilirsiniz.
            },
            child: Text("Ekle"),
          ),
          ElevatedButton(
            onPressed: () {
              // Kaydetme butonu işlevi
              // Buraya kaydetme işlemleri ekleyebilirsiniz.
            },
            child: Text("Kaydet"),
          ),
        ],
      ),
    );
  }
}
