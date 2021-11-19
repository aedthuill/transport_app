// @dart=2.9

import 'package:fl_app/main.dart';
import 'package:fl_app/models/TransportWithRoutes.dart';
import 'package:fl_app/screens/InfoForUsers.dart';
import 'package:fl_app/screens/MapPage.dart';
import 'package:fl_app/screens/NotifScreen.dart';

import 'package:fl_app/service/TransportService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'MarshrutPage.dart';
import 'Settings.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TransportService service = getIt<TransportService>();

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Дорис-Ассистент.Волгоград',
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16 * textScale),
        ),
      ),
      body: FutureBuilder(
          future: service.getTransportWithRoutes(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<TransportWithRoutes> transport = snapshot.data;
            print(transport?.toString());
            return (transport == null)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: transport.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: ListTile(
                              title: Container(
                                width: 100,
                                height: 60,
                                child: Center(
                                    child: Text(
                                  transport[index].transport.ttTitle,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20 * textScale),
                                )),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MarshrutsPage(
                                              ttId: transport[index]
                                                  .transport
                                                  .ttId,
                                            )));
                              },
                            ),
                          ),
                        ),
                      );
                    });
          }),
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
             DrawerHeader(
              decoration: BoxDecoration(
              ),
              child: Center(child: Text(
                'Дорис-Ассистент.Волгоград', style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 16 * textScale
              )
              ),),
            ),
            ListTile(
              leading: Icon(Icons.message, color: Colors.grey,),
              title:  Text(
                AppLocalizations.of(context).menu,
                style: GoogleFonts.montserrat(fontSize: 14.0 * textScale),
              ),
              onTap: () async {
                await launch("mailto: tvolganet@gmail.com");
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.grey),
              title:  Text(
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


