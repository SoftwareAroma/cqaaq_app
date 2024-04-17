// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportModelImpl _$$ReportModelImplFromJson(Map<String, dynamic> json) =>
    _$ReportModelImpl(
      id: json['id'] as String,
      date: json['date'] as String,
      site: json['site'] as String,
      reportId: json['reportId'] as String,
      reporterId: json['reporterId'] as String,
      reporterUid: json['reporterUid'] as String,
      grainage: json['grainage'] as String,
      moi: json['moi'] as String?,
      truckNumber: json['truckNumber'] as String?,
      data: (json['data'] as List<dynamic>)
          .map((e) => ReportCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ReportModelImplToJson(_$ReportModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'site': instance.site,
      'reportId': instance.reportId,
      'reporterId': instance.reporterId,
      'reporterUid': instance.reporterUid,
      'grainage': instance.grainage,
      'moi': instance.moi,
      'truckNumber': instance.truckNumber,
      'data': instance.data,
    };

_$ReportCategoryImpl _$$ReportCategoryImplFromJson(Map<String, dynamic> json) =>
    _$ReportCategoryImpl(
      column1: json['column1'] as String,
      column2: json['column2'] as String,
      column3: json['column3'] as String,
      column4: json['column4'] as String,
    );

Map<String, dynamic> _$$ReportCategoryImplToJson(
        _$ReportCategoryImpl instance) =>
    <String, dynamic>{
      'column1': instance.column1,
      'column2': instance.column2,
      'column3': instance.column3,
      'column4': instance.column4,
    };
