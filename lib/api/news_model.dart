class News {
  final String author;
  final String title;
  final String description;
  final String imageUrl;
  final String content;

  const News({
    required this.author,
    required this.content,
    required this.description,
    required this.imageUrl,
    required this.title,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      author: json["author"] ?? "",
      content: json["content"] ?? "",
      description: json["description"] ?? "",
      imageUrl: json["urlToImage"] ?? "",
      title: json["title"] ?? "",
    );
  }

  static List<News> newsList(dynamic jsonList) {
    List articles = jsonList["articles"] as List;
    List<News> newsList =
        List.from(articles.map((newsItem) => News.fromJson(newsItem)));
    return newsList;
  }
}
