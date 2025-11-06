import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../features/services/meal_service.dart';


class MealList extends StatelessWidget {
  final String parsedate;
  final VoidCallback onReload;
  const MealList({super.key, required this.parsedate, required this.onReload});


  Future<List<Widget>> getCards() async {
    List<Card> cards = [];
    for (final meal in await getMeals(parsedate)) {
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
