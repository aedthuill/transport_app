// @dart=2.9

import 'package:fl_app/models/RouteWithStops.dart';
import 'package:fl_app/models/Routes.dart';
import 'package:fl_app/service/TransportService.dart';
import 'package:fl_app/service/sharedPrefService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import 'HomeSceen.dart';
import 'InfoForUsers.dart';
import 'MapPage.dart';
import 'Settings.dart';

class FavsSavePage extends StatefulWidget {
  final int ttId;

  const FavsSavePage({Key key, this.ttId}) : super(key: key);

  @override
  _FavsSavePageState createState() => _FavsSavePageState();
}

class _FavsSavePageState extends State<FavsSavePage> {
  Box<RouteWithStops> favoriteRoutesBox;
  TransportService service = getIt<TransportService>();
  List<RouteWithStops> _routes = [];
  TextEditingController _editingController;
  UserSimplePreferences sharedPref = UserSimplePreferences();
  RouteWithStops routeSave = RouteWithStops();

  Routes routesRenamedSave = Routes();

  @override
  void initState() {
    service.getMarshrutWithStops(widget.ttId).then((value) {
      setState(() {
        _routes.addAll(value);
      });
    });
    favoriteRoutesBox = Hive.box(favoritesBox);
    _editingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Избранное",
          style: GoogleFonts.montserrat(fontSize: 16 * textScale),
        ),
      ),
      body: (_routes == null)
          ? CircularProgressIndicator()
          : ValueListenableBuilder(
              valueListenable: favoriteRoutesBox.listenable(),
              builder: (context, Box<RouteWithStops> box, _) {
                List<RouteWithStops> _routes = List.from(box.values.toList());
                return (_routes == null)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: _routes.length,
                        itemBuilder: (builder, index) {
                          return ListTile(
                              title: Text(
                                _routes[index].route.mrTitle,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14 * textScale),
                              ),
                          );
                        });
              },
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
              title:  Text('Написать разработчику',  style:
              GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 15 * textScale),),
              onTap: () async {
                await launch("mailto: tvolganet@gmail.com");
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.grey),
              title:  Text('Общая информация', style:
              GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 15 * textScale),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfoForUsers()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications_active, color: Colors.grey),
              title:  Text('Уведомления', style:
              GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 15 * textScale),),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
