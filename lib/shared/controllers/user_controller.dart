import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cqaaq_app/index.dart';

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
      }
    });
  }

  /// get [UserModel] profile data
  Future<void> getUserProfile() async {
    try {
      final UserModel userModel = await userRepo.getUserData();
      // logger.i("userModel: $userModel");
      updateUser(userModel);
    } catch (e) {
      logger.e("error getting user profile: $e");
    }
    update();
  }

  User? get currentUser => _currentFirebaseUser.value;
  UserModel? get user => _userModel.value;
  List<ReportModel> get reports => _reports;
}
