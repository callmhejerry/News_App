import 'package:news_app/Domain/enities.dart';

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
      imageUrl: json["urlToImage"] ??
          "https://demofree.sirv.com/nope-not-here.jpg?w=150",
      title: json["title"] ?? "",
    );
  }

  static List<NewsEntity> newsList(dynamic jsonList) {
    List articles = jsonList["articles"] as List;
    List<NewsEntity> newsList = List.from(
        articles.map((newsItem) => News.fromJson(newsItem).toNewsEntity()));
    return newsList;
  }
}

extension NewsX on News {
  NewsEntity toNewsEntity() {
    return NewsEntity(
      author: author,
      title: title,
      description: description,
      imageUrl: imageUrl,
      content: content,
    );
  }
}

class HeadlineNewsModel {
  final String title;
  final String description;
  final String urlToImage;
  final String content;

  const HeadlineNewsModel({
    required this.content,
    required this.description,
    required this.title,
    required this.urlToImage,
  });

  HeadlineNewsModel.fromJson(Map<String, dynamic> json)
      : title = json["title"] ?? "",
        description = json["description"] ?? "",
        urlToImage = json["urlToImage"] ??
            "https://demofree.sirv.com/nope-not-here.jpg?w=150",
        content = json["content"] ?? "";

  static List<HeadLineEntity> fromList(dynamic json) {
    List articles = json["articles"] as List;
    List<HeadLineEntity> newsList = List.from(articles.map(
        (newsItem) => HeadlineNewsModel.fromJson(newsItem).toHeadlineEntity()));
    return newsList;
  }
}

extension HeadlineX on HeadlineNewsModel {
  HeadLineEntity toHeadlineEntity() {
    return HeadLineEntity(
      content: content,
      description: description,
      title: title,
      urlToImage: urlToImage,
    );
  }
}
