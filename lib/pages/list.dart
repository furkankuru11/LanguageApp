import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:languageapp/pages/create_list.dart';
import 'package:languageapp/db/db/db.dart';
import 'package:languageapp/pages/words.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Map<String, Object?>> _lists = [];
  bool pressController = false;

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
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateList()))
                .then((value) {});
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 25,
          ),
          backgroundColor: Color(0xFF003840)),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "İngilizce Sözlük",
          style: GoogleFonts.notoSansOsmanya(
              color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return listItem(_lists[index]['list_id'] as int,
                listName: _lists[index]['name'].toString(),
                sumWords: _lists[index]['sum_word'].toString(),
                sumUnlearned: _lists[index]['sum_unlearned'].toString());
          },
          itemCount: _lists.length,
        ),
      ),
    );
  }

  void delete(int id) async {
    await DB.instance.deleteListsAndWordByList(id);
    setState(() {
      _lists.removeWhere((element) => element['list_id'] == id);
    });
  }

  Widget listItem(int? id,
      {@required String? listName,
      @required String? sumWords,
      @required String? sumUnlearned}) {
    return Dismissible(
      key: Key(id.toString()),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Emin misiniz?"),
              content: Text("Bu listeyi silmek istediğinizden emin misiniz?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("İptal"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("Evet, Sil"),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        delete(id!);
      },
      background: Container(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Icon(
              Icons.delete_forever_outlined,
              color: Color(0xFF02A676),
            ),
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Color.fromARGB(255, 228, 50, 50),
        margin: EdgeInsets.only(top: 20),
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            size: 30,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ), // Sağa doğru kaydırma işlemini kaldırıyoruz
      direction: DismissDirection
          .endToStart, // Yalnızca sola doğru kaydırma izin veriliyor
      child: InkWell(
        onTap: () {
          debugPrint(id.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WordsPage(
                        listName: listName,
                        listID: id,
                      )));
        },
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFF007369)),
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    width: double.infinity,
                    height: 130,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                listName!,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "${sumWords!}: Terim",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "${(int.parse(sumWords) - int.parse(sumUnlearned!))}: Kelime Öğrenildi",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "${sumUnlearned!}: Kelime Öğrenilecek",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
