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
      imageUrl: json["urlToImage"] ?? "",
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
      : title = json["title"],
        description = json["description"],
        urlToImage = json["urlToImage"],
        content = json["content"];

  List<HeadlineNewsModel> fromList(List json) {
    List<HeadlineNewsModel> headlineNewsList =
        json.map((item) => HeadlineNewsModel.fromJson(item)).toList();
    return headlineNewsList;
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
