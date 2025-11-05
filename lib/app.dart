import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schmackofatz/shared/widgets/about_dialog.dart' as customabout;
import 'package:schmackofatz/shared/widgets/meal_list_widget.dart';

import 'features/models/mensen.dart';
import 'features/services/meal_service.dart';

class SchmackoApp extends StatelessWidget {
  const SchmackoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schmackofatz',
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.orange, brightness: Brightness.dark)),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Speiseplan Mensa Leipzig'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Mensen? _mensen = Mensen.ampark;
  Key _tabBarViewKey = UniqueKey();


  void _reloadMealLists() {
    // <-- NEUE METHODE
    setState(() {
      _tabBarViewKey = UniqueKey();
    });
  }

  String getMensaName() {
    if (_mensen == Mensen.ampark) {
      return "Mensa am Park";
    } else if (_mensen == Mensen.academica) {
      return "Mensa Academica";
    } else if (_mensen == Mensen.botanischergarten) {
      return "Mensa am Botanischen Garten";
    } else if (_mensen == Mensen.elsterbecken) {
      return "Mensa am Elsterbecken";
    } else if (_mensen == Mensen.dittrichring) {
      return "Cafeteria Dittrichring";
    } else if (_mensen == Mensen.medizin) {
      return "Mensa am Medizincampus";
    } else if (_mensen == Mensen.petersteinweg) {
      return "Mensa am Petersteinweg";
    } else if (_mensen == Mensen.schoenauer) {
      return "Mensa Schönauer Straße";
    } else if (_mensen == Mensen.tierkliniken) {
      return "Mensa an den Tierkliniken";
    } else {
      return "Kein Name gegeben";
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(getMensaName()),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return buildSizedBox(context);
                    });
              },
              icon: const Icon(Icons.location_on_outlined),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        customabout.AboutDialog());
              },
              icon: const Icon(Icons.info_outline),
            ),
          ],
          bottom: TabBar(isScrollable: true, tabs: <Widget>[
            const Tab(text: "Heute"),
            const Tab(text: "Morgen"),
            Tab(
                text: DateFormat('dd.MM.')
                    .format(DateTime.now().add(const Duration(days: 2)))),
            Tab(
                text: DateFormat('dd.MM.')
                    .format(DateTime.now().add(const Duration(days: 3)))),
            Tab(
                text: DateFormat('dd.MM.')
                    .format(DateTime.now().add(const Duration(days: 4)))),
            Tab(
                text: DateFormat('dd.MM.')
                    .format(DateTime.now().add(const Duration(days: 5)))),
          ]),
        ),
        body: TabBarView(
          key: _tabBarViewKey,
          children: [
            MealList(
              parsedate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
              onReload: _reloadMealLists,
            ),
            MealList(
                parsedate: DateFormat('yyyy-MM-dd')
                    .format(DateTime.now().add(const Duration(days: 1))),
                onReload: _reloadMealLists),
            MealList(
                parsedate: DateFormat('yyyy-MM-dd')
                    .format(DateTime.now().add(const Duration(days: 2))),
                onReload: _reloadMealLists),
            MealList(
                parsedate: DateFormat('yyyy-MM-dd')
                    .format(DateTime.now().add(const Duration(days: 3))),
                onReload: _reloadMealLists),
            MealList(
                parsedate: DateFormat('yyyy-MM-dd')
                    .format(DateTime.now().add(const Duration(days: 4))),
                onReload: _reloadMealLists),
            MealList(
                parsedate: DateFormat('yyyy-MM-dd')
                    .format(DateTime.now().add(const Duration(days: 5))),
                onReload: _reloadMealLists),
          ],
        ),
      ),
    );
  }

  SizedBox buildSizedBox(BuildContext context) {
    return SizedBox(
        height: 400,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RadioListTile<Mensen>(
                        title: const Text('Mensa am Park'),
                        value: Mensen.ampark,
                        groupValue: _mensen,
                        onChanged: (Mensen? value) {
                          MySettings.config["location"] = "106";
                          Navigator.of(context).pop();
                          setState(() {
                            _mensen = value;
                          });
                        }),
                    RadioListTile<Mensen>(
                        title: const Text('Mensa Peterssteinweg'),
                        value: Mensen.petersteinweg,
                        groupValue: _mensen,
                        onChanged: (Mensen? value) {
                          Navigator.of(context).pop();
                          MySettings.config["location"] = "111";
                          setState(() {
                            _mensen = value;
                          });
                        }),
                    RadioListTile<Mensen>(
                        title: const Text('Mensa am Elsterbecken'),
                        value: Mensen.elsterbecken,
                        groupValue: _mensen,
                        onChanged: (Mensen? value) {
                          Navigator.of(context).pop();
                          MySettings.config["location"] = "115";
                          setState(() {
                            _mensen = value;
                          });
                        }),
                    RadioListTile<Mensen>(
                        title: const Text('Mensa Academica'),
                        value: Mensen.academica,
                        groupValue: _mensen,
                        onChanged: (Mensen? value) {
                          Navigator.of(context).pop();
                          MySettings.config["location"] = "118";
                          setState(() {
                            _mensen = value;
                          });
                        }),
                    RadioListTile<Mensen>(
                        title: const Text('Mensa am Medizincampus'),
                        value: Mensen.medizin,
                        groupValue: _mensen,
                        onChanged: (Mensen? value) {
                          Navigator.of(context).pop();
                          MySettings.config["location"] = "162";
                          setState(() {
                            _mensen = value;
                          });
                        }),
                    RadioListTile<Mensen>(
                        title: const Text('Mensa am Botanischen Garten'),
                        value: Mensen.botanischergarten,
                        groupValue: _mensen,
                        onChanged: (Mensen? value) {
                          Navigator.of(context).pop();
                          MySettings.config["location"] = "127";
                          setState(() {
                            _mensen = value;
                          });
                        }),
                    RadioListTile<Mensen>(
                        title: const Text('Mensa an den Tierkliniken'),
                        value: Mensen.tierkliniken,
                        groupValue: _mensen,
                        onChanged: (Mensen? value) {
                          Navigator.of(context).pop();
                          MySettings.config["location"] = "170";
                          setState(() {
                            _mensen = value;
                          });
                        }),
                    RadioListTile(
                        title: const Text('Mensa Schönauer Straße'),
                        value: Mensen.schoenauer,
                        groupValue: _mensen,
                        onChanged: (Mensen? value) {
                          Navigator.of(context).pop();
                          MySettings.config["location"] = "140";
                          setState(() {
                            _mensen = value;
                          });
                        }),
                    RadioListTile(
                        title: const Text('Cafeteria Dittrichring'),
                        value: Mensen.dittrichring,
                        groupValue: _mensen,
                        onChanged: (Mensen? value) {
                          Navigator.of(context).pop();
                          MySettings.config["location"] = "153";
                          setState(() {
                            _mensen = value;
                          });
                        }),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
