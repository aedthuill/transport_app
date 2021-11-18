// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'HomeSceen.dart';
import 'MapPage.dart';
import 'NotifScreen.dart';
import 'Settings.dart';

class InfoForUsers extends StatelessWidget {
  InfoForUsers({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    print(textScale);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).name5,
          style: GoogleFonts.montserrat(
              fontSize: 16.0 * textScale, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          child: Column(children: [
        ListTile(
          title: Text(
            AppLocalizations.of(context).info,
            style: GoogleFonts.montserrat(fontSize: 14.0 * textScale),
          ),
          trailing: Text(
            AppLocalizations.of(context).payment,
            style: GoogleFonts.montserrat(
                fontSize: 14.0 * textScale, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context).info1,
            style: GoogleFonts.montserrat(fontSize: 14.0 * textScale),
          ),
          trailing: Text(
            AppLocalizations.of(context).payment1,
            style: GoogleFonts.montserrat(
                fontSize: 14.0 * textScale, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context).info2,
            style: GoogleFonts.montserrat(fontSize: 14.0 * textScale),
          ),
          trailing: Text(
            AppLocalizations.of(context).payment2,
            style: GoogleFonts.montserrat(
                fontSize: 14.0 * textScale, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context).info3,
            style: GoogleFonts.montserrat(fontSize: 14.0 * textScale),
          ),
          trailing: Text(
            AppLocalizations.of(context).payment3,
            style: GoogleFonts.montserrat(
                fontSize: 14.0 * textScale, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context).info4,
            style: GoogleFonts.montserrat(fontSize: 14.0 * textScale),
          ),
          trailing: Text(
            AppLocalizations.of(context).payment4,
            style: GoogleFonts.montserrat(
                fontSize: 14.0 * textScale, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context).info5,
            style: GoogleFonts.montserrat(fontSize: 14.0 * textScale),
          ),
          trailing: Text(
            AppLocalizations.of(context).payment5,
            style: GoogleFonts.montserrat(
                fontSize: 14.0 * textScale, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: Text(
            'Создано на технологиях Транснавигация',
            style: GoogleFonts.montserrat(fontSize: 14.0 * textScale),
          ),
        ),
        ListTile(
          title: Text(
            'Создано на технологиях Open Street Map',
            style: GoogleFonts.montserrat(fontSize: 14.0 * textScale),
          ),
        ),
      ])),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await launch("mailto: gh_gh@volgadmin.ru");
        },
        label: Text("Пожаловаться на работу транспорта"),
        backgroundColor: Colors.red[800],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
              IconButton(
                  icon: Icon(Icons.home, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homescreen()),
                    );
                  }),
              IconButton(
                  icon: Icon(Icons.favorite, color: Colors.grey),
                  onPressed: () {
                    Navigator.pushNamed(context, 'favorite');
                  }),
              IconButton(
                  icon: Icon(Icons.map, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapPage()),
                    );
                  }),
            ]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             DrawerHeader(
              decoration: BoxDecoration(),
              child: Center(
                  child: Text(
                    'Дорис-Ассистент.Волгоград', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
              )),
            ),
            ListTile(
              leading: Icon(
                Icons.message,
                color: Colors.grey,
              ),
              title: Text(
                AppLocalizations.of(context).menu,
                style: GoogleFonts.montserrat(fontSize: 14.0 * textScale),
              ),
              onTap: () async {
                await launch("mailto: tvolganet@gmail.com");
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.grey),
              title: Text(
                AppLocalizations.of(context).menu1,
                style: GoogleFonts.montserrat(fontSize: 14.0 * textScale),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfoForUsers()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications_active, color: Colors.grey),
              title: Text(
                AppLocalizations.of(context).name4,
                style: GoogleFonts.montserrat(fontSize: 14.0 * textScale),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotifScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
