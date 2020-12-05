import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/constants.dart';
import 'package:news/home/firestore.dart';
import 'package:news/home/newsDialog.dart';

import 'package:news/models/newsModel.dart';
import 'package:share/share.dart';

class TopHeadlines extends StatefulWidget {
  TopHeadlines({Key key, this.size, this.headlinesNews, this.connectionStatus})
      : super(key: key);
  final Size size;
  final List<NewsModel> headlinesNews;
  final connectionStatus;
  @override
  TopHeadlinesState createState() => TopHeadlinesState();
}

class TopHeadlinesState extends State<TopHeadlines> {
  final String appLink =
      "https://www.linkedin.com/in/panguluri-koumudi-411b21159/";
  // bool _favorites = false;
  void _showDetails(context, news) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("${news.name} - ${news.author}",
                  style: GoogleFonts.playfairDisplay(
                      textStyle: TextStyle(
                    color: textColor,
                    fontSize: 20,
                  ))),
              content: new Text(news.title,
                  style: GoogleFonts.ptSans(
                      textStyle: TextStyle(
                    color: textColor,
                    fontSize: 20,
                  ))),
              actions: <Widget>[
                NewsDetails(
                    particularNews: news,
                    connectionStatus: widget.connectionStatus)
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    print(
        "each news ${widget.headlinesNews.length} and ${widget.headlinesNews[0].image} and $widget.connectionStatus");
    return Column(
        children: widget.headlinesNews.map((news) {
      // _favorites = false;
      return Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Card(
            child: Column(children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  widget.connectionStatus == 'none'
                      ? Image.asset("assets/images/news.jpg")
                      : Image.network(news.image),
                  Container(
                      color: Colors.white.withOpacity(0.85),
                      padding: EdgeInsets.only(
                          left: defaultPadding, right: defaultPadding),
                      child: Column(children: [
                        Text(news.title != null ? news.title : "World news",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 18)),
                      ])),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        print("clicked on share");
                        Share.share(
                                "News from Koumi news app.\n${news.title}\n${news.url}\n\nFor furture news updates, please download $appLink")
                            .then((value) => {
                                  setDetails(shares: news.title),
                                });
                      }),
                  Spacer(flex: 5),
                  FlatButton(
                    child: Text(
                      "More",
                      style:
                          GoogleFonts.teko(color: Colors.green, fontSize: 22),
                    ),
                    onPressed: () {
                      print("particular news ${news.title}");
                      _showDetails(context, news);
                    },
                  ),
                  Spacer(flex: 5),
                  IconButton(
                      icon: Icon(
                        Icons.bookmark_border,
                      ),
                      onPressed: () {
                        setDetails(likes: news.title);
                        print("fav clicked");
                        // setState(() {
                        //   widget.headlinesNews.map((value) {
                        //     if (value.id == news.id) {
                        //       _favorites = true;
                        //     }
                        //   });
                        // });
                      }),
                ],
              ),
            ]),
          ));
    }).toList());
  }
}
