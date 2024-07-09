// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WorkHistoryModel _$WorkHistoryModelFromJson(Map<String, dynamic> json) {
  return _WorkHistoryModel.fromJson(json);
}

/// @nodoc
mixin _$WorkHistoryModel {
  String get company => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  bool get stillWorking => throw _privateConstructorUsedError;
  String? get endDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkHistoryModelCopyWith<WorkHistoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkHistoryModelCopyWith<$Res> {
  factory $WorkHistoryModelCopyWith(
          WorkHistoryModel value, $Res Function(WorkHistoryModel) then) =
      _$WorkHistoryModelCopyWithImpl<$Res, WorkHistoryModel>;
  @useResult
  $Res call(
      {String company,
      String position,
      String startDate,
      bool stillWorking,
      String? endDate});
}

/// @nodoc
class _$WorkHistoryModelCopyWithImpl<$Res, $Val extends WorkHistoryModel>
    implements $WorkHistoryModelCopyWith<$Res> {
  _$WorkHistoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? company = null,
    Object? position = null,
    Object? startDate = null,
    Object? stillWorking = null,
    Object? endDate = freezed,
  }) {
    return _then(_value.copyWith(
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      stillWorking: null == stillWorking
          ? _value.stillWorking
          : stillWorking // ignore: cast_nullable_to_non_nullable
              as bool,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkHistoryModelImplCopyWith<$Res>
    implements $WorkHistoryModelCopyWith<$Res> {
  factory _$$WorkHistoryModelImplCopyWith(_$WorkHistoryModelImpl value,
          $Res Function(_$WorkHistoryModelImpl) then) =
      __$$WorkHistoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String company,
      String position,
      String startDate,
      bool stillWorking,
      String? endDate});
}

/// @nodoc
class __$$WorkHistoryModelImplCopyWithImpl<$Res>
    extends _$WorkHistoryModelCopyWithImpl<$Res, _$WorkHistoryModelImpl>
    implements _$$WorkHistoryModelImplCopyWith<$Res> {
  __$$WorkHistoryModelImplCopyWithImpl(_$WorkHistoryModelImpl _value,
      $Res Function(_$WorkHistoryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? company = null,
    Object? position = null,
    Object? startDate = null,
    Object? stillWorking = null,
    Object? endDate = freezed,
  }) {
    return _then(_$WorkHistoryModelImpl(
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      stillWorking: null == stillWorking
          ? _value.stillWorking
          : stillWorking // ignore: cast_nullable_to_non_nullable
              as bool,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkHistoryModelImpl implements _WorkHistoryModel {
  _$WorkHistoryModelImpl(
      {required this.company,
      required this.position,
      required this.startDate,
      required this.stillWorking,
      this.endDate});

  factory _$WorkHistoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkHistoryModelImplFromJson(json);

  @override
  final String company;
  @override
  final String position;
  @override
  final String startDate;
  @override
  final bool stillWorking;
  @override
  final String? endDate;

  @override
  String toString() {
    return 'WorkHistoryModel(company: $company, position: $position, startDate: $startDate, stillWorking: $stillWorking, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkHistoryModelImpl &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.stillWorking, stillWorking) ||
                other.stillWorking == stillWorking) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, company, position, startDate, stillWorking, endDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkHistoryModelImplCopyWith<_$WorkHistoryModelImpl> get copyWith =>
      __$$WorkHistoryModelImplCopyWithImpl<_$WorkHistoryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkHistoryModelImplToJson(
      this,
    );
  }
}

abstract class _WorkHistoryModel implements WorkHistoryModel {
  factory _WorkHistoryModel(
      {required final String company,
      required final String position,
      required final String startDate,
      required final bool stillWorking,
      final String? endDate}) = _$WorkHistoryModelImpl;

  factory _WorkHistoryModel.fromJson(Map<String, dynamic> json) =
      _$WorkHistoryModelImpl.fromJson;

  @override
  String get company;
  @override
  String get position;
  @override
  String get startDate;
  @override
  bool get stillWorking;
  @override
  String? get endDate;
  @override
  @JsonKey(ignore: true)
  _$$WorkHistoryModelImplCopyWith<_$WorkHistoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
