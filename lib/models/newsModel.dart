class NewsModel {
  final String id, name, author, title, description, url, image, publishedAt;
  NewsModel({
    this.id,
    this.name,
    this.author,
    this.title,
    this.description,
    this.url,
    this.image,
    this.publishedAt,
  });

  static getData(topHeadlines, value, image) {
    return topHeadlines.add(NewsModel(
      id: value["source"]["id"] != null ? value["source"]["id"] : "id",
      name: value["source"]["name"] != null
          ? value["source"]["name"]
          : "News Today",
      author: value["author"] != null ? value["author"] : "News Today",
      title: value["title"] != null ? value["title"] : "News Today",
      description:
          value["description"] != null ? value["description"] : "News Today",
      url: value["url"] != null ? value["url"] : "News Today",
      image: value["urlToImage"] != null ? value["urlToImage"] : image,
      publishedAt: value["publishedAt"] != null
          ? value["publishedAt"]
          : DateTime.now().toString(),
    ));
  }
}
