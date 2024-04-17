import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_model.freezed.dart';
part 'news_model.g.dart';

@freezed
class NewsModel with _$NewsModel {
  factory NewsModel({
    SourceModel? source,
    required String title,
    required String description,
    required String publishedAt,
    required String content,
    required String url,
    String? urlToImage,
    String? author,
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);
}

@freezed
class SourceModel with _$SourceModel {
  factory SourceModel({
    String? id,
    required String name,
  }) = _SourceModel;

  factory SourceModel.fromJson(Map<String, dynamic> json) => _$SourceModelFromJson(json);
}
