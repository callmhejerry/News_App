// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enities.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsEntityAdapter extends TypeAdapter<NewsEntity> {
  @override
  final int typeId = 1;

  @override
  NewsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsEntity(
      author: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String,
      imageUrl: fields[4] as String,
      content: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NewsEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
