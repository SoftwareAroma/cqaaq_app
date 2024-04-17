import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestorePaths {
  /// [FirebaseFirestore] collections paths
  static String get usersCollection => 'users';
  static String get reportsCollection => 'reports';
  static String get notificationsCollection => 'notifications';
  static String get messagesCollection => 'messages';

  static String userDocument(String id) => '$usersCollection/$id';
  static String reportDocument(String id) => '$reportsCollection/$id';

  /// [FirebaseStorage] paths
  static String get userImagesPath => 'user_images/avatar';
  static String get caseImagesPath => 'report_images/images';

  // FirebaseStorage
  static String profilesImagesPath(String userId) => '$userImagesPath/$userId';
}
