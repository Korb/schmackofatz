import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Element;
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import '../models/meals.dart';

class MySettings {
  static Map<String, String> config = {
    "location": "106",
    "name": "Mensa am Park"
  };
}

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

Future<List<Meal>> getMeals(String parsedate) async {
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
                .replaceAll(RegExp(r' {2}\b(?!Vegan\b|Vegetarisch\b).*'), "")
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
      if (kDebugMode) {
        print("--- FEHLER BEIM PARSEN EINES GERICHTS ---");
        print("Fehlermeldung: $e");
        print("Problem-HTML: ${meal.outerHtml}");
        print("-----------------------------------------");
      }
    }

  }
  return meals;
}
