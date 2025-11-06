import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutDialog extends StatelessWidget{
  const AboutDialog({super.key});

  static const String version = "2.0.2";


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