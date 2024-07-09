import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_history_model.freezed.dart';
part 'work_history_model.g.dart';

@freezed
class WorkHistoryModel with _$WorkHistoryModel {
  factory WorkHistoryModel({
    required String company,
    required String position,
    required String startDate,
    required bool stillWorking,
    String? endDate,
  }) = _WorkHistoryModel;

  factory WorkHistoryModel.fromJson(Map<String, dynamic> json) => _$WorkHistoryModelFromJson(json);
}
