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
      author: json["author"] as String,
      content: json["content"] as String,
      description: json["description"] as String,
      imageUrl: json["urlToImage"] as String,
      title: json["title"] as String,
    );
  }

  static List<News> newsList(dynamic jsonList) {
    List articles = jsonList["article"] as List;
    List<News> newsList =
        List.from(articles.map((newsItem) => News.fromJson(newsItem)));
    return newsList;
  }
}
