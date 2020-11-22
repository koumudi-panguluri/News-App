import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:news/constants.dart';
import 'package:news/home/hive.dart';
import 'package:news/home/topBar.dart';
import 'package:news/home/topHeadlines.dart';
import 'package:news/home/newsApis.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/newsModel.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:news/home/flutterNotifications.dart';

class Body extends StatefulWidget {
  final String payload;
  Body({this.payload});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final topHeadlinesUrl = topHeadlines;
  List<NewsModel> allTopHeadlines = [];
  final imageUrl = image;
  var connectionStatus;

  //declaration, put, get

  void noNetwork(context) {
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
    FlutterNotifications.getNotificationInitialization();
    getHeadlines();
  }

  Future<void> getHeadlines() async {
    await HiveDB.openBox();
    tz.initializeTimeZones();

    var connectionResult = await Connectivity().checkConnectivity();
    if (connectionResult == ConnectivityResult.none) {
      connectionStatus = 'none';
      noNetwork(context);
    } else {
      connectionStatus = 'connected';
    }

    var headlinesHive = HiveDB.getDataFromHive(allTopHeadlines, 0);
    print("topheadlines in body ${headlinesHive.length}");
    setState(() {
      allTopHeadlines = headlinesHive;
    });
    return http.get(topHeadlinesUrl).then((response) {
      var headlines;

      print(
          "headlines from front page ${json.decode(response.body)["articles"].length}");
      headlines = json.decode(response.body);
      print("headlines from front page ${headlines["articles"].length}");
      //offline caching
      HiveDB.putDataToHive(headlines["articles"], allTopHeadlines, 0)
          .then((value) {
        var headlinesHive = HiveDB.getDataFromHive(allTopHeadlines, 0);
        print("topheadlines in body ${headlinesHive.length}");
        setState(() {
          allTopHeadlines = headlinesHive;
          if (headlines != null && headlines["articles"].length > 0) {
            if (headlines["articles"][0]["title"] != allTopHeadlines[0].title) {
              print("data updated");

              FlutterNotifications.flutterAlarm();

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
              ? TopHeadlines(
                  size: size,
                  headlinesNews: allTopHeadlines,
                  connectionStatus: connectionStatus)
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
