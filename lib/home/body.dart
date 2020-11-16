import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news/constants.dart';
import 'package:news/home/topBar.dart';
import 'package:news/home/topHeadlines.dart';
import 'package:news/home/newsApis.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/newsModel.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final topHeadlinesUrl = topHeadlines;
  List<NewsModel> allTopHeadlines = [];
  final imageUrl = image;
  Box box;

  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('data');
    return;
  }

  Future putDataToHive(newsHeadlines) async {
    await box.clear();
    allTopHeadlines = [];
    for (var data in newsHeadlines) {
      box.add(data);
    }
  }

  void getDataFromHive() {
    var newsData;
    final List<NewsModel> topHeadlines = [];
    allTopHeadlines = [];
    newsData = box.toMap().values.toList();
    print("news list ${newsData.length}");
    (newsData as List).map((value) {
      return NewsModel.getData(topHeadlines, value, image);
    }).toList();
    setState(() {
      allTopHeadlines = topHeadlines;
    });
  }

  void initState() {
    super.initState();
    getHeadlines();
  }

  Future<void> getHeadlines() async {
    await openBox();

    getDataFromHive();
    return http.get(topHeadlinesUrl).then((response) {
      var headlines;

      print(
          "headlines from front page ${json.decode(response.body)["articles"].length}");
      headlines = json.decode(response.body);
      print("headlines from front page ${headlines["articles"].length}");
      //offline caching
      putDataToHive(headlines["articles"]);
      getDataFromHive();

      // (headlines["articles"] as List).map((value) {
      //   return NewsModel.getData(topHeadlines, value, image);
      // }).toList();

      print("headlines $topHeadlines");
    }).catchError((err) {
      print("Error occured $err");
      throw err;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          TopBar(size),
          allTopHeadlines.isNotEmpty
              ? TopHeadlines(size, allTopHeadlines)
              : Container(
                  margin: EdgeInsets.all(defaultPadding),
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                  )),
        ],
      ),
    );
  }
}

//  FutureBuilder(
//               future: getHeadlines(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   if (allTopHeadlines.length != null) {
//                     return TopHeadlines(size, allTopHeadlines);
//                   } else {
//                     return Text('No data found');
//                   }
//                 } else {
//                   return Container(
//                       margin: EdgeInsets.all(defaultPadding),
//                       child: CircularProgressIndicator(
//                         strokeWidth: 5,
//                       ));
//                 }
//               })
