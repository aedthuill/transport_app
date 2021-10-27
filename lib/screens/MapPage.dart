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
import 'Settings.dart';

/*
* здесь карта вместе с отображением остановок
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
        title: Text('Остановки на карте'),
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
                        builder: (_) => Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(child: Text(e.stDesc, overflow: TextOverflow.visible,)),
                                  Expanded(child: Icon(Icons.person_pin)),
                                ],
                              ),
                        )))
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

                //HERE IS ON TAP OPTIONS
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
                      borderColor: Colors.blueAccent,
                      color: Colors.black12,
                      borderStrokeWidth: 3),
                  builder: (context, markers) {
                    return FloatingActionButton(
                      child: Text(markers.length.toString()),
                      onPressed: null,
                    );
                  },
                ),
              ],
            );
          }
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
              child: Center(child: Text('Transport.Volganet', )),
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
              title:  Text(
                AppLocalizations.of(context).name4,
                style: GoogleFonts.montserrat(fontSize: 14.0 * textScale),
              ),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
 
  }

