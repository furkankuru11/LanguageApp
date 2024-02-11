import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DrawerMenu extends StatefulWidget {
  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  String version = "";

  final _url = Uri.parse('https://flutter.dev');

  PackageInfo? packageInfo;

  void packageInfoInit() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        version = packageInfo.version;
      });
    } catch (e) {
      print("Hata :$e");
    }
  }

  @override
  void initState() {
    super.initState();
    packageInfoInit();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.language_sharp,
                  color: Colors.white,
                  size: 90,
                ),
                SizedBox(height: 10),
                Text(
                  'İngilizce Sözlük',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Anasayfa'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profil'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Hakkında'),
            onTap: () async {
              try {
                if (!await launchUrl(_url)) {
                  throw Exception('Giriş Yapılamadı $_url');
                }
              } catch (e) {
                print('Hata: $e');
              }
            },
          ),
          SizedBox(
            height: height * 0.53,
          ), // Araya biraz boşluk ekleyebiliriz
          Center(
            child: Text(
              'v$version',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
