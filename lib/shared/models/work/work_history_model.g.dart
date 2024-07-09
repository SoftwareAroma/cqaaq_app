// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkHistoryModelImpl _$$WorkHistoryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WorkHistoryModelImpl(
      company: json['company'] as String,
      position: json['position'] as String,
      startDate: json['startDate'] as String,
      stillWorking: json['stillWorking'] as bool,
      endDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$$WorkHistoryModelImplToJson(
        _$WorkHistoryModelImpl instance) =>
    <String, dynamic>{
      'company': instance.company,
      'position': instance.position,
      'startDate': instance.startDate,
      'stillWorking': instance.stillWorking,
      'endDate': instance.endDate,
    };
