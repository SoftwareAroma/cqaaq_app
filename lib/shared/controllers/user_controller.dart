import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cqaaq_app/index.dart';

/// [FirebaseFirestore] instance
final FirebaseFirestore _userFirebaseFirestore = FirebaseFirestore.instance;

/// [FirebaseAuth] instance
final FirebaseAuth _auth = FirebaseAuth.instance;

class UserController extends GetxController {
  static final UserController _instance = Get.find();
  static UserController get instance => _instance;

  final _isUserLoggedIn = false.obs;
  final _currentFirebaseUser = Rxn<User>();
  final _userModel = Rxn<UserModel>();
  final _reports = <ReportModel>[].obs;

  /// Side Effects
  getUserReports() async {
    List<ReportModel> reports = await reportRepo.getUserReports();
    updateReports(reports);
  }

  updateReports(List<ReportModel> reports) {
    _reports.clear();
    _reports.addAll(reports);
    update();
  }

  void updateUser(UserModel userModel) {
    _userModel.value = userModel;
    // getUserReports();
  }

  /// initialize user
  void initUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _currentFirebaseUser.value = user;
      if (user != null) {
        _isUserLoggedIn.value = true;
        getUserProfile();
      } else {
        _isUserLoggedIn.value = false;
        _userModel.value = null;
      }
    });
  }

  /// get [UserModel] profile data
  Future<void> getUserProfile() async {
    try {
      final UserModel? userModel = await userRepo.getUserData();
      logger.i("userModel: $userModel");
      if (userModel != null) {
        updateUser(userModel);
      }
    } catch (e) {
      logger.e("error getting user profile: $e");
    }
    update();
  }

  /// update profile picture
  Future<bool> updateProfilePicture(File avatar) async {
    try {
      String avatarUrl = await userRepo.uploadImageWithFile(
        avatar,
        folderName: "avatars",
      );

      logger.d("Avatar url: $avatarUrl");

      /// get user's data from firestore
      await _userFirebaseFirestore.collection(FirestorePaths.userImagesPath).doc(_auth.currentUser!.uid).update({
        'avatar': avatarUrl,
      });
      await getUserProfile();
      return true;
    } catch (e) {
      logger.e("Error getting user data: $e");
      return false;
    }
  }

  User? get currentUser => _currentFirebaseUser.value;
  UserModel? get user => _userModel.value;
  List<ReportModel> get reports => _reports;
}
