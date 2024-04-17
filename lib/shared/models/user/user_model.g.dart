// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      uid: json['uid'] as String,
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      region: json['region'] as String,
      reports:
          (json['reports'] as List<dynamic>).map((e) => e as String).toList(),
      district: json['district'] as String?,
      position: json['position'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      otherName: json['otherName'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'region': instance.region,
      'reports': instance.reports,
      'district': instance.district,
      'position': instance.position,
      'email': instance.email,
      'phone': instance.phone,
      'otherName': instance.otherName,
      'avatar': instance.avatar,
    };
