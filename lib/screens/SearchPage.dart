// @dart=2.9

import 'package:fl_app/models/StopsForMap.dart';
import 'package:fl_app/service/ApiService.dart';
import 'package:fl_app/service/sharedPrefService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';
import 'HomeSceen.dart';
import 'InfoForUsers.dart';
import 'MapPage.dart';
import 'NotifScreen.dart';
import 'Settings.dart';

//здесь лежит поиск по остановкам и добавление в избранное
//да, в одном файле
//также тут еще и переименовывание (мб допилю)

//поиск по списку
class StopSerachFavs extends StatefulWidget {
  const StopSerachFavs({Key key}) : super(key: key);

  @override
  _StopSerachFavsState createState() => _StopSerachFavsState();
}

class _StopSerachFavsState extends State<StopSerachFavs> {
  List<Stop> _stops = [];
  List<Stop> _stopsToDisplay = [];
  Box<Stop> favoriteRoutesBox;

  @override
  void initState() {
    favoriteRoutesBox = Hive.box(favorBox);
    fetchStops().then((value) {
      setState(() {
        _stops.addAll(value);
        _stopsToDisplay = _stops;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        title: Text( AppLocalizations.of(context).name8),
      ),
      body: (_stops == null)
          ? CircularProgressIndicator()
          : ValueListenableBuilder(
              valueListenable: favoriteRoutesBox.listenable(),
              builder: (context, Box<Stop> box, _) {
                return ListView.builder(
                    itemCount: _stopsToDisplay.length + 1,
                    itemBuilder: (context, index) {
                      return index == 0 ? _searchBar() : _listItem(index - 1);
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
            const DrawerHeader(
              decoration: BoxDecoration(
              ),
              child: Center(child: Text('Transport.Volganet',)),
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

  _listItem(index) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return ListTile(
      title: Text(_stopsToDisplay[index].stTitle,
          style: TextStyle(
            fontSize: 16 * textScale,
          )),
      trailing: IconButton(
        icon: getIcon(index),
        onPressed: () {
          onFavoritePress(index);
        },
      ),
      onTap: () {},
    );
  }

  Widget getIcon(int index) {
    if (favoriteRoutesBox.containsKey(index)) {
      return Icon(Icons.star, color: Colors.amber[800]);
    }
    return Icon(Icons.star_border);
  }

  void onFavoritePress(int index) {
    if (favoriteRoutesBox.containsKey(index)) {
      favoriteRoutesBox.delete(_stops[index].stId);
      return;
    }
    favoriteRoutesBox.put(index, _stops[index]);
  }

  _searchBar() {
    print('test1');
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Поиск маршрута',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            print('object');
            _stopsToDisplay = _stops.where((element) {
              var stopsTitle = element.stTitle.toLowerCase();
              print(stopsTitle);
              return stopsTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }
}

//избранные остановки

class FavoriteStops extends StatefulWidget {
  const FavoriteStops({Key key}) : super(key: key);

  @override
  _FavoriteStopsState createState() => _FavoriteStopsState();
}

class _FavoriteStopsState extends State<FavoriteStops> {
  List<Stop> _stops = [];
  Box<Stop> favoriteRoutesBox;
  TextEditingController myTextController = TextEditingController();

  UserSimplePreferences sharedPref = UserSimplePreferences();

  @override
  void initState() {
    favoriteRoutesBox = Hive.box(favorBox);
    fetchStops().then((value) {
      setState(() {
        _stops.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
        appBar: AppBar(
          title: Text('Rename favourites'),
        ),
        body: (_stops == null)
            ? CircularProgressIndicator()
            : ValueListenableBuilder(
                valueListenable: favoriteRoutesBox.listenable(),
                builder: (context, Box<Stop> box, _) {
                  List<Stop> _stops = List.from(box.values.toList());
                  return (_stops == null)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: _stops.length,
                          itemBuilder: (builder, index) {
                            return ListTile(
                              title: Text(
                                _stops[index].stTitle,
                                style: GoogleFonts.montserrat(),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: TextField(
                                              controller: myTextController
                                                ..text = _stops[index].stTitle,
                                              autofocus: false,
                                              decoration: InputDecoration(
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0)),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0)),
                                                        borderSide:
                                                            BorderSide()),
                                                border: InputBorder.none,
                                              ),

                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    await setState(() {
                                                      sharedPref.save(
                                                          'route', _stops);
                                                    });
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text('Saved'),
                                                      duration: const Duration(
                                                          milliseconds: 10),
                                                    ));
                                                  },
                                                  child: Text('Saved rename')),
                                            ],
                                          ));
                                },
                              ),
                            );
                          });
                }
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
