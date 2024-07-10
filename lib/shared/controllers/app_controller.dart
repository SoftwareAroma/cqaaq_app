import 'package:cqaaq_app/index.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppController extends GetxController {
  static final AppController _instance = Get.find();
  static AppController get instance => _instance;

  final List<LanguageModel> _languages = <LanguageModel>[
    const LanguageModel(image: Assets.flagsUs, language: "English - US"),
    const LanguageModel(image: Assets.flagsGb, language: "English - GB"),
    const LanguageModel(image: Assets.flagsGh, language: "English - GH"),
  ];
  final _appVersion = "1.0.0".obs;
  final _activeLanguage = Rxn<LanguageModel>();
  final RxList<UserModel> _users = <UserModel>[].obs;

  updateVersion() async {
    initLanguage();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    _appVersion.value = version;
  }

  initLanguage() {
    _activeLanguage.value = _languages.last;
  }

  updateActiveLanguage({required LanguageModel language}) {
    _activeLanguage.value = language;
  }

  updateUsers(List<UserModel> users) {
    _users.addAll(users);
    update();
  }

  fetchUsers() async {
    List<UserModel> users = await userRepo.getUsers();
    // logger.i("users >>> ${users}");
    updateUsers(users);
  }

  UserModel? getUser(String id) {
    if (_users.isEmpty) return null;
    UserModel user = _users.firstWhere((UserModel user) => user.id == id);
    return user;
  }

  String get appVersion => _appVersion.value;
  List<LanguageModel> get languages => _languages;
  List<UserModel> get users => _users;
  LanguageModel get activeLanguage => _activeLanguage.value!;
}
