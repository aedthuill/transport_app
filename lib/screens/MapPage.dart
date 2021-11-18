// @dart=2.9

import 'package:fl_app/models/StopsForMap.dart';
import 'package:fl_app/service/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart' as latLong;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'HomeSceen.dart';
import 'InfoForUsers.dart';
import 'NotifScreen.dart';
import 'Settings.dart';

/*
* здесь карта вместе с отображением остановок
* на остановку необхожимо нажать и тогда вспылевт алерт-диалог с ее названием, затем снова тыкнуть на карту и алерт-диалог скроется
* так намного эффективнее потому что этот бесплатный плагин может во всплывающем окне показать только широту и долготу
* также еще один цикл не добавить производительности
* */
class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final PopupController _popupController = PopupController();

  @override
  void initState() {
    futureStops = fetchStops();
    super.initState();
  }

  Future<List<Stop>> futureStops;
  List<Marker> allMarkers = [];
  List<Stop> listStops = [];
  List<Text> options = [];

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).name7,
          style: GoogleFonts.montserrat(
              fontSize: 16.0 * textScale, fontWeight: FontWeight.w400),
        ),
      ),
      body: FutureBuilder<List<Stop>>(
          future: fetchStops(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              listStops = snapshot.data;
              print('POINT 1');
              listStops.forEach((element) {
                allMarkers = listStops
                    .map((e) => Marker(
                          point: latLong.LatLng(e.stLat, e.stLong),
                          builder: (_) => IconButton(
                            icon: Icon(Icons.person_pin),
                            iconSize: 30,
                            onPressed: () {
                              return   showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text(e.stTitle),
                                    actions: [
                                      TextButton(
                                          onPressed: () { Text(e.stTitle); },
                                          child: Text('Ok')),
                                    ],
                                  ));
                            },
                          ),
                        ))
                    .toList(growable: true);
              });
            }
            return FlutterMap(
              options: new MapOptions(
                center: latLong.LatLng(48.7068, 44.5171),
                zoom: 13,
                plugins: [
                  MarkerClusterPlugin(),
                  LocationMarkerPlugin(),
                ],
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                LocationMarkerLayerOptions(),
                MarkerClusterLayerOptions(
                  maxClusterRadius: 120,
                  size: Size(40, 40),
                  markers: allMarkers,
                  polygonOptions: PolygonOptions(
                      borderColor: Colors.green[300],
                      color: Colors.green,
                      borderStrokeWidth: 3),
                  builder: (context, markers) {
                    return FloatingActionButton(
                      child: Text(markers.length.toString()),
                      onPressed: null,
                      heroTag: 'btn1',
                    );
                  },
                ),
              ],
            );
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
