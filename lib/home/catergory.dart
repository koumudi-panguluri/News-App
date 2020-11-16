import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/constants.dart';
import 'package:news/home/categoryNews.dart';
import 'package:news/home/newsApis.dart';

class Category extends StatelessWidget {
  final Size size;
  Category(this.size);
  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Container(
            height: (size.height * 0.3),
            margin: EdgeInsets.only(
              left: defaultPadding,
              right: defaultPadding,
              top: defaultPadding * 10,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xff8896AB).withOpacity(0.2)),
            child: Stack(children: [
              Container(
                margin: EdgeInsets.only(
                    top: defaultPadding * 0.15,
                    left: defaultPadding,
                    bottom: defaultPadding),
                child: Text(
                  "Recommended",
                  style: GoogleFonts.teko(
                    fontSize: 18.0,
                    textStyle: TextStyle(color: backgroundColor),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(defaultPadding),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _images("assets/images/health.png", "Health",
                        healthHeadlines, context),
                    _images("assets/images/business.jpg", "Business",
                        businessHeadlines, context),
                    _images("assets/images/entertainment.png", "Entertainment",
                        entertainmentHeadlines, context),
                    _images("assets/images/science1.jpg", "Science",
                        scienceHeadlines, context),
                    _images("assets/images/technology.jpg", "Tech",
                        technologyHeadlines, context),
                    _images("assets/images/sports.jpg", "Sports",
                        sportsHeadlines, context),
                  ],
                ),
              )
            ])));
  }
}

Widget _images(imagePath, name, url, context) {
  return GestureDetector(
    onTap: () {
      print("tapped");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CategoryNews(name, url)),
      );
    },
    child: Container(
      margin: EdgeInsets.all(defaultPadding * 0.3),
      child: Card(
        elevation: 5,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Image.asset(
            imagePath,
            width: 150,
          ),
          Container(
            child: Text(
              name,
              style: GoogleFonts.teko(
                fontSize: 20.0,
                textStyle: TextStyle(color: textColor),
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        ]),
      ),
    ),
  );
}
