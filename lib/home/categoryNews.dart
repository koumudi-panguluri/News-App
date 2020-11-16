import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news/constants.dart';
import 'package:news/home/topHeadlines.dart';
import 'package:news/models/newsModel.dart';
import 'package:http/http.dart' as http;

class CategoryNews extends StatefulWidget {
  final String name;
  final String url;
  CategoryNews(this.name, this.url);
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var headlinesUrl = "";
  List<NewsModel> allTopHeadlines = [];
  final imageUrl = image;

  void initState() {
    super.initState();
    headlinesUrl = widget.url;
    getHeadlines();
  }

  Future<void> getHeadlines() {
    return http.get(headlinesUrl).then((response) {
      var headlines;
      final List<NewsModel> topHeadlines = [];
      print(
          "headlines from front page ${json.decode(response.body)["articles"].length}");
      headlines = json.decode(response.body);
      print("headlines from front page ${headlines["articles"].length}");
      (headlines["articles"] as List).map((value) {
        return NewsModel.getData(topHeadlines, value, image);
      }).toList();
      setState(() {
        allTopHeadlines = topHeadlines;
      });
      print("headlines in categoryNews $topHeadlines");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("name ${widget.name} url ${widget.url}");
    return Scaffold(
      appBar: AppBar(
        title: Text("World News - ${widget.name} News"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: allTopHeadlines.isNotEmpty
            ? TopHeadlines(size, allTopHeadlines)
            : Container(
                margin: EdgeInsets.all(defaultPadding * 5),
                child: Column(children: [
                  Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 5,
                  ))
                ])),
      ),
    );
  }
}
