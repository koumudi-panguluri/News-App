import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/constants.dart';
import 'package:news/models/newsModel.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatelessWidget {
  final NewsModel particularNews;
  NewsDetails(this.particularNews);

  _launchURL() async {
    final url = particularNews.url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Card(
            child: Image.network(particularNews.image),
          ),
        ),
        Container(
            child: Column(children: [
          myText("Description"),
          myText(particularNews.description)
        ])),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            myButton('Know More?', _launchURL, context),
            myButton('Close me!', _launchURL, context)
          ],
        )),
      ],
    );
  }
}

Widget myText(text) {
  if (text == 'Description') {
    return Text(
      text,
      style: GoogleFonts.teko(
          textStyle: TextStyle(
              color: Colors.blue, fontSize: 25, fontWeight: FontWeight.normal)),
    );
  } else {
    return Text(
      text,
      style: GoogleFonts.oswald(
          textStyle: TextStyle(
              color: textColor, fontSize: 20, fontWeight: FontWeight.normal)),
    );
  }
}

Widget myButton(text, _launchURL, context) {
  if (text == 'Know More?') {
    return FlatButton(
      child: Text(
        text,
        style: GoogleFonts.abel(
            textStyle: TextStyle(
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
      onPressed: _launchURL,
    );
  } else {
    return FlatButton(
      child: Text(
        text,
        style: GoogleFonts.abel(
            textStyle: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
