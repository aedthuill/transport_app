// @dart=2.9

import 'package:fl_app/models/RouteWithStops.dart';
import 'package:fl_app/service/TransportService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../main.dart';
import 'HomeSceen.dart';
import 'InfoForUsers.dart';
import 'MapPage.dart';
import 'NotifScreen.dart';
import 'Settings.dart';


//страница с остановками из алгоритма
//почему тут нельзя сделать избранное и почему тут нельзя сделать поиск?
//потому что само строение АПИ и его функциональный стиль не предполагает, что получаемые огстановки пад капотом будут списком
//оно выводится как список, но списком не является. Смотри в последнуюю функцию в алгоритме
class StopPage extends StatefulWidget {
  final RouteWithStops routeWithStops;

  const StopPage({Key key, this.routeWithStops}) : super(key: key);

  @override
  State<StopPage> createState() => _StopPageState();
}

class _StopPageState extends State<StopPage> {
  Box<RouteWithStops> favoriteRoutesBox;
  final df = new DateFormat('dd-MM-yyyy hh:mm a');

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    TransportService service = getIt<TransportService>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).name1,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400, fontSize: 14 * textScale),
        ),
      ),
      body: FutureBuilder(
          future: service.fetchStopsInfo(widget.routeWithStops),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            RouteWithStops routes = snapshot.data;
            print(routes?.toString());
            return (routes == null)
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: routes.stop.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          routes.stop[index].stTitle,
                          style: GoogleFonts.montserrat(
                              fontSize: 14.0 * textScale),
                        ),
                        subtitle: Text((df.format(
                                routes.stop[index].timeArrival ??
                                    AppLocalizations.of(context).name11))
                            .toString()),
                      );
                    },
                  );
          }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await launch("mailto: priemnaya@gcupp34.ru");
          },
          label: Text('Оставить жалобу МКП ГЦУПП')),
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
              decoration: BoxDecoration(),
              child: Center(
                  child: Text(
                'Transport.Volganet',
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
