// @dart=2.9

import 'package:fl_app/service/ChangingTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'HomeSceen.dart';
import 'InfoForUsers.dart';
import 'MapPage.dart';
import 'NotifScreen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text( AppLocalizations.of(context).name3,
    style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 20 * textScale)),
        ),
        body:  Center(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text( AppLocalizations.of(context).desc,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 14 * textScale)),
                  trailing: Checkbox(
                      checkColor: Colors.white,
                      value: themeChange.darkTheme,
                      onChanged: (bool value) {
                        themeChange.darkTheme = value;
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                      AppLocalizations.of(context).desc1,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 14 * textScale)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                      AppLocalizations.of(context).desc2,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 14 * textScale)),
                ),
              )
            ]),
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
                ), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );},
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
                  icon: Icon(Icons.map, color: Colors.grey), onPressed: () {
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
            const DrawerHeader(
              decoration: BoxDecoration(
              ),
              child: Center(child: Text('Transport.Volganet',)),
            ),
            ListTile(
              leading: Icon(Icons.message, color: Colors.grey,),
              title:  Text(
                  AppLocalizations.of(context).menu,
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 14 * textScale)
              ),
              onTap: () async {
                await launch("mailto: tvolganet@gmail.com");
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.grey),
              title:  Text(
                  AppLocalizations.of(context).menu1,
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 14 * textScale)
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
              title:   Text(
                  AppLocalizations.of(context).name4,
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 14 * textScale)
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
