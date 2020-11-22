import 'package:hive/hive.dart';
import 'package:news/constants.dart';
import 'package:news/models/newsModel.dart';
import 'package:path_provider/path_provider.dart';

class HiveDB {
  static List<Box> boxList = [];
  final imageUrl = image;
  static Future<List<Box>> openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    var boxHeadlines = await Hive.openBox("boxHeadlines");
    var boxHealth = await Hive.openBox("boxHealth");
    var boxBusiness = await Hive.openBox("boxBusiness");
    var boxEntertainment = await Hive.openBox("boxEntertainment");
    var boxScience = await Hive.openBox("boxScience");
    var boxTech = await Hive.openBox("boxTech");
    var boxSports = await Hive.openBox("boxSports");
    boxList.add(boxHeadlines);
    boxList.add(boxHealth);
    boxList.add(boxBusiness);
    boxList.add(boxEntertainment);
    boxList.add(boxScience);
    boxList.add(boxTech);
    boxList.add(boxSports);
    return boxList;
  }

  static Future putDataToHive(newsHeadlines, allTopHeadlines, index) async {
    await boxList[index].clear();
    allTopHeadlines = [];
    for (var data in newsHeadlines) {
      boxList[index].add(data);
    }
  }

  static dynamic getDataFromHive(allTopHeadlines, index) {
    var newsData;
    final List<NewsModel> topHeadlines = [];
    allTopHeadlines = [];
    newsData = boxList[index].toMap().values.toList();
    print("news list ${newsData.length}");
    (newsData as List).map((value) {
      return NewsModel.getData(topHeadlines, value, image);
    }).toList();
    return topHeadlines;
  }
}
