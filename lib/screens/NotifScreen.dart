// @dart=2.9
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_app/main.dart';
import 'package:fl_app/service/LocalNotif.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'HomeSceen.dart';
import 'InfoForUsers.dart';
import 'MapPage.dart';
import 'Settings.dart';

class NotifScreen extends StatefulWidget {
  const NotifScreen({
    Key key,
  }) : super(key: key);

  @override
  _NotifScreenState createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {

  @override
  void initState() {
    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if(message != null){
        final routeFromMessage = message.data["route"];

        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification != null){
        print(message.notification.body);
        print(message.notification.title);
        showDialog(context: context,  builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message.notification.body),
            content: Text(message.notification.title),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('Ok'))
            ],
          );
        });
      }

      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];

      Navigator.of(context).pushNamed(routeFromMessage);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
        appBar: AppBar(
          title: Text('Уведомления', style: GoogleFonts.montserrat()),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Здесь будут ваши уведомления"),
                  )
                ],
              ),
            ),
          ),
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
              title:  Text('Написать разработчику'),
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
