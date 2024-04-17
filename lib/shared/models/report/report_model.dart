import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

@freezed
class ReportModel with _$ReportModel {
  factory ReportModel({
    required String id,
    required String date,
    required String site,
    required String reportId,
    required String reporterId,
    required String reporterUid,
    required String grainage,
    String? moi,
    String? truckNumber,
    required List<ReportCategory> data,
  }) = _ReportModel;

  factory ReportModel.fromJson(Map<String, dynamic> json) => _$ReportModelFromJson(json);
}

@freezed
class ReportCategory with _$ReportCategory {
  factory ReportCategory({
    required String column1,
    required String column2,
    required String column3,
    required String column4,
  }) = _ReportCategory;

  factory ReportCategory.fromJson(Map<String, dynamic> json) => _$ReportCategoryFromJson(json);
}
