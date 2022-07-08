import 'package:hive/hive.dart';

part 'enities.g.dart';

@HiveType(typeId: 1)
class NewsEntity {
  @HiveField(1)
  final String author;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String imageUrl;
  @HiveField(5)
  final String content;

  NewsEntity({
    required this.author,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
  });
}
