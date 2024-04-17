// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsModelImpl _$$NewsModelImplFromJson(Map<String, dynamic> json) =>
    _$NewsModelImpl(
      source: json['source'] == null
          ? null
          : SourceModel.fromJson(json['source'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      publishedAt: json['publishedAt'] as String,
      content: json['content'] as String,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String?,
      author: json['author'] as String?,
    );

Map<String, dynamic> _$$NewsModelImplToJson(_$NewsModelImpl instance) =>
    <String, dynamic>{
      'source': instance.source,
      'title': instance.title,
      'description': instance.description,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'author': instance.author,
    };

_$SourceModelImpl _$$SourceModelImplFromJson(Map<String, dynamic> json) =>
    _$SourceModelImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$SourceModelImplToJson(_$SourceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
