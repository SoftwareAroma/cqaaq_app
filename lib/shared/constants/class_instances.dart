import 'package:cqaaq_app/index.dart';
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';

/// [GetIt] instance
final GetIt locator = GetIt.instance;

/// [ServiceInitializer] instance
final ServiceInitializer serviceInitializer = ServiceInitializer.instance;

/// [GetxController] instances
final NewsController newsController = NewsController.instance;
final UserController userController = UserController.instance;
final AppController appController = AppController.instance;
final ReportsController reportsController = ReportsController.instance;

/// [UserRepo] instance
final UserRepo userRepo = UserRepo.instance;

/// [UserRepo] instance
final NewsRepo newsRepo = NewsRepo.instance;

/// [ReportRepo] instance
final ReportRepo reportRepo = ReportRepo.instance;
