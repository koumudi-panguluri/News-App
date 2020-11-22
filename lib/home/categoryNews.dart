import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:news/constants.dart';
import 'package:news/home/hive.dart';
import 'package:news/home/newsApis.dart';
import 'package:news/home/topHeadlines.dart';
import 'package:news/models/newsModel.dart';
import 'package:http/http.dart' as http;

class CategoryNews extends StatefulWidget {
  final String name;
  final String url;
  final index;
  CategoryNews(this.name, this.url, this.index);
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var headlinesUrl = "";
  List<NewsModel> allTopHeadlines = [];
  final imageUrl = image;
  var connectionStatus;

  void noNetwork() {
    final scaff = Scaffold.of(context);
    scaff.showSnackBar(SnackBar(
      content: Text("Please check your Network connection"),
      duration: Duration(seconds: 5),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: scaff.hideCurrentSnackBar,
      ),
    ));
  }

  void initState() {
    super.initState();
    headlinesUrl = widget.url;
    getHeadlines();
  }

  Future<void> getHeadlines() async {
    await HiveDB.openBox();

    var connectionResult = await Connectivity().checkConnectivity();
    if (connectionResult == ConnectivityResult.none) {
      connectionStatus = 'none';
      // noNetwork();
    } else {
      connectionStatus = 'connected';
    }

    var headlinesHive = HiveDB.getDataFromHive(allTopHeadlines, widget.index);
    print("topheadlines in body ${headlinesHive.length}");
    setState(() {
      allTopHeadlines = headlinesHive;
    });
    return http.get(headlinesUrl).then((response) {
      var headlines;

      print(
          "headlines from front page ${json.decode(response.body)["articles"].length}");
      headlines = json.decode(response.body);
      print("headlines from front page ${headlines["articles"].length}");
      //offline caching
      HiveDB.putDataToHive(headlines["articles"], allTopHeadlines, widget.index)
          .then((value) {
        var headlinesHive =
            HiveDB.getDataFromHive(allTopHeadlines, widget.index);
        print("topheadlines in body ${headlinesHive.length}");
        setState(() {
          allTopHeadlines = headlinesHive;
          if (headlines != null &&
              headlines["articles"].length > widget.index) {
            if (headlines["articles"][0]["title"] != allTopHeadlines[0].title) {
              print("data updated");

              print(
                  "data ${headlines["articles"][0]["title"]} and ${allTopHeadlines[0].title}");
            } else {
              print("old data");

              print(
                  "data ${headlines["articles"][0]["title"]} and ${allTopHeadlines[0].title}");
            }
          }
        });
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
            ? TopHeadlines(
                size: size,
                headlinesNews: allTopHeadlines,
                connectionStatus: connectionStatus,
              )
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
