import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cqaaq_app/index.dart';

class ServiceInitializer {
  ServiceInitializer._();
  static final ServiceInitializer instance = ServiceInitializer._();

  initializeSettings() async {
    await initializeFirebase();
    await initializeDataLayer();
    initializeOrientationPreferences();
    setupUrlLauncherServices();
  }

// register services and factories
  setupUrlLauncherServices() {
    // register service
    locator.registerSingleton<CallServices>(CallServices());
    locator.registerSingleton<SmsServices>(SmsServices());
    locator.registerSingleton<EmailServices>(EmailServices());
    locator.registerSingleton<WebServices>(WebServices());
  }

  // set up call services

  // initialize data layer
  initializeDataLayer() async {
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => AppController());
    Get.lazyPut(() => NewsController());
    Get.lazyPut(() => ReportsController());
  }

  /// initialize [FirebaseApp], [FirebaseFirestore]
  Future<void> initializeFirebase() async {
    /// user app initialization
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    /// Initialize Firebase Analytics.
    await FirebaseAnalytics.instance.logAppOpen();
  }

  /// initialize orientation preferences
  initializeOrientationPreferences() {
    // handle display orientation on various devices
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight,
    ]);

    // system ui mode
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }
}
