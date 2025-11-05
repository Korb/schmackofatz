import 'package:flutter/material.dart' hide Element;
import 'package:html/dom.dart' hide Text;
import 'package:intl/intl.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


const String version = "2.0.0";

void main() {
  runApp(const MyApp());
}

enum Mensen {ampark, petersteinweg, elsterbecken, academica, medizin, botanischergarten, tierkliniken, schoenauer, dittrichring}

class MySettings {
  static Map<String, String> config = {
    "location": "106",
    "name": "Mensa am Park"
  };

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange, brightness: Brightness.dark)
      ),
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

  void _reloadMealLists() { // <-- NEUE METHODE
    setState(() {_tabBarViewKey = UniqueKey();
    });
  }


  String getMensaName () {
    if (_mensen == Mensen.ampark) {
      return "Mensa am Park";
    } else if (_mensen == Mensen.academica) {
      return "Mensa Academica";
    } else if (_mensen == Mensen.botanischergarten) {
      return "Mensaria am Botanischen Garten";
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
    } else {return "Kein Name gegeben";}
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
            ],),
          actions: [
            IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context)
                  {
                    return SizedBox(
                        height: 400,
                        child: SingleChildScrollView(child: Center(
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
                                        });}
                                  ),
                                  RadioListTile<Mensen>(
                                      title: const Text('Mensa Peterssteinweg'),
                                      value: Mensen.petersteinweg,
                                      groupValue: _mensen,
                                      onChanged: (Mensen? value) {
                                        Navigator.of(context).pop();
                                        MySettings.config["location"] = "111";
                                        setState(() {
                                          _mensen = value;
                                        });}
                                  ),
                                  RadioListTile<Mensen>(
                                      title: const Text('Mensa am Elsterbecken'),
                                      value: Mensen.elsterbecken,
                                      groupValue: _mensen,
                                      onChanged: (Mensen? value) {
                                        Navigator.of(context).pop();
                                        MySettings.config["location"] = "115";
                                        setState(() {
                                          _mensen = value;
                                        });}
                                  ),
                                  RadioListTile<Mensen>(
                                      title: const Text('Mensa Academica'),
                                      value: Mensen.academica,
                                      groupValue: _mensen,
                                      onChanged: (Mensen? value) {
                                        Navigator.of(context).pop();
                                        MySettings.config["location"] = "118";
                                        setState(() {
                                          _mensen = value;
                                        });}
                                  ),
                                  RadioListTile<Mensen>(
                                      title: const Text('Mensa am Medizincampus'),
                                      value: Mensen.medizin,
                                      groupValue: _mensen,
                                      onChanged: (Mensen? value) {
                                        Navigator.of(context).pop();
                                        MySettings.config["location"] = "162";
                                        setState(() {
                                          _mensen = value;
                                        });}
                                  ),
                                  RadioListTile<Mensen>(
                                      title: const Text('Mensa am Botanischen Garten'),
                                      value: Mensen.botanischergarten,
                                      groupValue: _mensen,
                                      onChanged: (Mensen? value) {
                                        Navigator.of(context).pop();
                                        MySettings.config["location"] = "127";
                                        setState(() {
                                          _mensen = value;
                                        });}
                                  ),
                                  RadioListTile<Mensen>(
                                      title: const Text('Mensa an den Tierkliniken'),
                                      value: Mensen.tierkliniken,
                                      groupValue: _mensen,
                                      onChanged: (Mensen? value) {
                                        Navigator.of(context).pop();
                                        MySettings.config["location"] = "170";
                                        setState(() {
                                          _mensen = value;
                                        });}
                                  ),
                                  RadioListTile(
                                      title: const Text('Mensa Schönauer Straße'),
                                      value: Mensen.schoenauer,
                                      groupValue: _mensen,
                                      onChanged: (Mensen? value) {
                                        Navigator.of(context).pop();
                                        MySettings.config["location"] = "140";
                                        setState(() {
                                          _mensen = value;
                                        });}
                                  ),
                                  RadioListTile(
                                      title: const Text('Cafeteria Dittrichring'),
                                      value: Mensen.dittrichring,
                                      groupValue: _mensen,
                                      onChanged: (Mensen? value) {
                                        Navigator.of(context).pop();
                                        MySettings.config["location"] = "153";
                                        setState(() {
                                          _mensen = value;
                                        });}
                                  ),

                                ],

                              )],
                          ),
                        ),
                        ));
                  });
            },
            icon: const Icon(Icons.location_on_outlined),
          ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        AboutDialog());
              },
              icon: const Icon(Icons.info_outline),
            ),
          ],

          bottom: TabBar(
              isScrollable: true,
              tabs: <Widget>[
                const Tab(
                    text: "Heute"
                ),
                const Tab(
                    text: "Morgen"
                ),
                Tab(
                    text: DateFormat('dd.MM.').format(DateTime.now().add(const Duration(days: 2)))
                ),
                Tab(
                    text: DateFormat('dd.MM.').format(DateTime.now().add(const Duration(days: 3)))
                ),
                Tab(
                    text: DateFormat('dd.MM.').format(DateTime.now().add(const Duration(days: 4)))
                ),
                Tab(
                    text: DateFormat('dd.MM.').format(DateTime.now().add(const Duration(days: 5)))
                ),
              ]
          ),
        ),
        body: TabBarView(
          key: _tabBarViewKey,
          children: [
            MealList(parsedate: DateFormat('yyyy-MM-dd').format(DateTime.now()), onReload: _reloadMealLists,),
            MealList(parsedate: DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 1))), onReload: _reloadMealLists),
            MealList(parsedate: DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 2))), onReload: _reloadMealLists ),
            MealList(parsedate: DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 3))), onReload: _reloadMealLists),
            MealList(parsedate: DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 4))), onReload: _reloadMealLists),
            MealList(parsedate: DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 5))), onReload: _reloadMealLists),
          ],

        ),
      ),
    );

  }
}





class Meal {
  final String title;
  final String subheadline;
  final String price1;
  final String type;
  final Icon icon;

  const Meal({
    required this.title,
    required this.subheadline,
    required this.price1,
    required this.type,
    required this.icon,
  });
}

class Variations {
  final String name;

  const Variations ({
    required this.name,
  });
}


class MealList extends StatelessWidget {
  final String parsedate;
  final VoidCallback onReload;
  const MealList({super.key, required this.parsedate, required this.onReload});


  Future<String> getDocument(String url) async {
    final response = await http
        .get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<List<Meal>> getMeals(DateTime date) async {
    List<Meal> meals = [];
    var location = MySettings.config["location"];
    var document = parse(await getDocument(
        "https://www.studentenwerk-leipzig.de/mensen-cafeterien/speiseplan/?location=$location&date=$parsedate"));
    var mealshtml = document.getElementById("page-content");

    if (mealshtml == null) {
      meals = [];
    }

    var mealContainer = mealshtml?.children[0].children[0].children.last.children[3].children;
    for (final meal in mealContainer!) {
      try {
        String type = meal.children[0].children[0].text;
        String name = meal.children[1].text;
        List<Element> prices;
        List<String> components = [];
        if (type == "Pastateller" || type == "Gemüsebeilage" ||
            type == "Sättigungsbeilage" || type == "Pizza" || type == "Grill") {
          prices = meal.children[2].children;
        } else {
          prices = meal.children[3].children;
          components.add(meal.children[2].text.trim());
        }
        String price = prices[0].text;

        String? subheadline = "";
        if (type == "Pastateller" || type == "Pizza") {
          for (final submeal in meal.children[3].children.last.children) {
            if (submeal.children[0].text.isNotEmpty) {
              components.add(submeal.children[0].text
                  .replaceAll(RegExp(r'  \b(?!Vegan\b|Vegetarisch\b).*'), "")
                  .replaceAll("Vegan", "🥕")
                  .replaceAll("Vegetarisch", "🧀").trim());
            }
          }

        } else if (type == "Grill") {
          for (final submeal in meal.children.last.children.last.children) {
            components.add(submeal.children[0].text.trim());
          }
          price = "";
        }
        subheadline = components.join("\n");
        IconData chosenicon = Icons.local_dining;
        switch(type) {
          case "Fleischgericht":
            chosenicon = Icons.kebab_dining;
            break;
          case "Fischgericht":
            chosenicon = Icons.phishing;
            break;
          case "Vegetarisches Gericht":
            chosenicon = Icons.egg;
            break;
          case "Veganes Gericht":
            chosenicon = Icons.eco;
            break;
          case "Pastateller":
            chosenicon = Icons.ramen_dining;
            break;
          case "Grill":
            chosenicon = Icons.outdoor_grill;
            break;
          case "Pizza":
            chosenicon = Icons.local_pizza;
            break;
          case "Gemüsebeilage":
            chosenicon = Icons.grass;
            break;
          case "Sättigungsbeilage":
            chosenicon = Icons.fastfood;
            break;
        }
        meals.add(Meal(title: name,
            subheadline: subheadline,
            price1: price,
            type: type,
            icon: Icon(chosenicon)));
      } catch (e) {
        print("--- FEHLER BEIM PARSEN EINES GERICHTS ---");
        print("Fehlermeldung: $e");
        // Gib das HTML des problematischen Elements aus, um es zu analysieren
        print("Problem-HTML: ${meal.outerHtml}");
        print("-----------------------------------------");
        // Optional: die Schleife fortsetzen, um andere, gültige Gerichte trotzdem zu laden
        // continue;
      }

    }
    return meals;
  }

  Future<List<Widget>> getCards() async {
    List<Card> cards = [];
    for (final meal in await getMeals(DateTime.now())) {
      cards.add(
          Card(
            child: Stack(
              children: [
                ListTile(
                  leading: meal.icon,
                  title: Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Text(meal.title)
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 50.0),
                    child: Text(meal.subheadline),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 12,
                  child: Text(
                    meal.price1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          )
      );
    }
    return cards;
  }


  @override
  Widget build(BuildContext context) {
    DateTime date = DateFormat("yyyy-MM-dd").parse(parsedate);
    if (date.weekday == DateTime.sunday) {
      return const Center(child: Text("Sonntags gibt's kein Essen!"));
    }
    if (date.weekday == DateTime.saturday) {
      return const Center(child: 
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Text("Ob vegetarisch, vegan, mit Fleisch oder Fisch – bei uns findest du genau das, was du suchst. Genieße frische Salate, köstliche Desserts und leckere Kuchen. Für jeden Geschmack ist etwas dabei!"),
        ),
            
      );
    }

    return SingleChildScrollView(
    child: Column(
      children: [
        FutureBuilder(
            future: getCards(),
            builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              "Fehler beim Laden der Daten:\n\n${snapshot.error}",
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: EdgeInsetsGeometry.all(16),
                              child:
                                TextButton.icon(
                                    onPressed: onReload,
                                    icon: const Icon(Icons.refresh),
                                    label: const Text("Neu laden"),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Theme.of(context).colorScheme.primary,
                                      foregroundColor: Colors.white,
                                    )
                                )
                            )
                          ]
                        )
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data as List<Widget>;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(children: data)
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator()
                );
            })
      ],
    ));

  }
}

class AboutDialog extends StatelessWidget{
  const AboutDialog({super.key});




  @override
  Widget build(BuildContext context,) {
    return AlertDialog(
      title: Row(crossAxisAlignment: CrossAxisAlignment.end,
        children: [
        Text("Schmackofatz"),
        Text(" v$version", style: TextStyle(
          fontSize: 20,
          color: Colors.grey[600],
        ),)
      ],),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              spacing: 0,
              children: [
                TextButton.icon(onPressed: () {},
                    icon: Icon(Icons.question_mark),
                    label: Row(
                      children: [
                        Expanded(child: Text("Speiseplan für Leipziger Student*innen")),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                    ),
                ),
                TextButton.icon(onPressed: () {_launchUrl("https://github.com/mattipunkt/schmackofatz");},
                  icon: Icon(Icons.code),
                  label: Row(
                    children: [
                      Text("GitHub"),
                      Spacer()
                    ],
                  ),
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                  )
                ),
                TextButton.icon(onPressed: () {_launchUrl("https://github.com/mattipunkt/schmackofatz/issues/new/choose");},
                    icon: Icon(Icons.flash_on),
                    label: Row(
                      children: [
                        Text("Fehler melden"),
                        Spacer()
                      ],
                    ),
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                    )
                ),
                TextButton.icon(onPressed: () {_launchUrl("https://www.reddit.com/r/dopsball/comments/1kgiosj/gekommen_um_zu_arbeiten_geblieben_um_zu_quatschen/");},
                    icon: Icon(Icons.favorite),
                    label: Row(
                      children: [
                        Text("Made with Love at Offener Inforaum"),
                        Spacer()
                      ],
                    ),
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                    )
                ),
              ],
            ),
          )

        ]
      ),
    );
  }

  Future<void> _launchUrl(String openUrl) async {
    final Uri url = Uri.parse(openUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch url');
    }
  }

}
