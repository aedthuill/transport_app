// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_app/models/RouteWithStops.dart';
import 'package:fl_app/models/Routes.dart';
import 'package:fl_app/screens/FavoritesPage.dart';
import 'package:fl_app/screens/HomeSceen.dart';
import 'package:fl_app/screens/NotifScreen.dart';
import 'package:fl_app/screens/SearchPage.dart';

import 'package:fl_app/service/ChangingTheme.dart';
import 'package:fl_app/service/TransportService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'l10n/l10n.dart';
import 'models/MarshrutVariant.dart';
import 'models/Stops.dart';
import 'models/StopsForMap.dart';


///Принимает уведомления, когда париложение на бэкграунде
///по гайдлайнам должна быть объявлена как глобальная переменная
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification.title);
}

const favoritesBox = 'favorite';
const favorBox = 'favsStop';
const FavsStopsBox = 'favsStopsBox';
final getIt = GetIt.asNewInstance();

Future<void> main() async {
  getIt.registerSingleton(TransportService());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  Hive.registerAdapter(RouteWithStopsAdapter());
  Hive.registerAdapter(StopListAdapter());
  Hive.registerAdapter(StopAdapter());
  Hive.registerAdapter(RoutesAdapter());
  Hive.registerAdapter(ScheduleVariantsAdapter());
  await Hive.initFlutter();
  await Hive.openBox<RouteWithStops>(favoritesBox);
  await Hive.openBox<Stop>(favorBox);
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) {
      return themeChangeProvider;
    }, child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
      return MaterialApp(
        theme: Styles.themeData(themeChangeProvider.darkTheme, context),
        debugShowCheckedModeBanner: false,
        home: Homescreen(),
        routes: {
          'favorite': (_) => FavsSavePage(),
          'favsStop': (_) => FavoriteStops(),
          "notif": (_) => NotifScreen(),
        },
        supportedLocales: L10n.all,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      );
    }));
  }
}
