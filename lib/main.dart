import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news/constants.dart';
import 'package:news/home/flutterNotifications.dart';
import 'package:workmanager/workmanager.dart';

import 'home/body.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // Workmanager.initialize(
  //   callbackDispatcher,
  //   isInDebugMode: true,
  // );
  // Workmanager.registerOneOffTask("1", "myTask", inputData: {"data1": "value1"});
  await Hive.initFlutter();
  runApp(MyApp());
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    print("Native called background task");
    // FlutterNotifications.getNotificationInitialization();
    // FlutterNotifications.flutterAlarm();
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: textColor),
        scaffoldBackgroundColor: backgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHome(title: 'World News'),
    );
  }
}

class MyHome extends StatefulWidget {
  MyHome({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text(widget.title),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ),
        body: Body());
  }
}
