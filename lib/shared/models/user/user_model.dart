import 'package:cqaaq_app/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String uid,
    required String id,
    required String firstName,
    required String lastName,
    required String region,
    required List<String> reports,
    required List<WorkHistoryModel> history,
    String? district,
    String? position,
    String? email,
    String? phone,
    String? otherName,
    String? avatar,
    String? about,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
